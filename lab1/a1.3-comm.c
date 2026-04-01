#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define CHUNK 1024

#define WAIT_T 500 * 1000

char msg[CHUNK];
int active = 0;
pid_t parent_pid;

void print_err(const char *s) {
    write(2, s, strlen(s));
}

void sighandler(int signum) {
    if (getpid() != parent_pid) return;
    sprintf(msg, "\nSIGINT: %3d child process(es) active\n", active);
    write(1, msg, strlen(msg));
}

int main(int argc, char *argv[]) {
    if (argc != 4) {
        sprintf(msg, "Usage: %s <input-file> <output-file> <char>\n", argv[0]);
        write(2, msg, strlen(msg));
        return 1;
    }
    struct sigaction sa;
    sa.sa_handler = sighandler;
    sa.sa_flags = SA_RESTART;
    if (sigaction(SIGINT, &sa, NULL) < 0) {
        print_err("error: sigaction failed\n");
        _exit(1);
    }
    parent_pid = getpid();
    int P = 13;
    int fdr, fdw;
    char c2c = argv[3][0];
    fdr = open(argv[1], O_RDONLY);
    if (fdr < 0) {
        print_err("error: cannot open file to read\n");
        _exit(1);
    }
    int pipefd[P][2];
    for (int i = 0; i < P; ++i) {
        if ((pipe(pipefd[i])) < 0) {
            print_err("error: cannot create pipe\n");
            _exit(1);
        }
    }
    struct stat st;
    if (fstat(fdr, &st) < 0) {
        perror("fstat");
        exit(1);
    }
    off_t end = st.st_size;
    off_t chunk_size = (end-1)/P+1;
    int res = 0;
    for (int i = 0; i < P; ++i) {
        active++;
        pid_t p = fork();
        usleep(WAIT_T);
        if (p < 0) {
            print_err("error: cannot fork process\n");
            _exit(1);
        } else if (p == 0) {
            int child_count = 0;
            char buff[chunk_size+1];
            ssize_t rcnt;
            rcnt = pread(fdr, buff, sizeof(buff)-1, chunk_size*i);
            if (rcnt == 0) /* end‐of‐file */
                break;
            if (rcnt < 0) { /* error */
                print_err("error: problem reading from input file\n");
                _exit(1);
            }
            for (int i = 0; i < rcnt; ++i) {
                if (buff[i] == c2c) {
                    child_count++;
                }
            }
            buff[rcnt] = '\0';
            // printf("Child %02d with PID %d: (%d)\t%s\n", i, getpid(), child_count, buff);
            if (write(pipefd[i][1], &child_count, sizeof(int)) != sizeof(int)) {
                print_err("error: cannot write to pipe\n");
                close(pipefd[i][1]);
                _exit(1);
            }
            close(pipefd[i][1]);
            _exit(0);
        }
    }
    int count;
    for (int i = 0; i < P; ++i) {
        close(pipefd[i][1]);
        if (read(pipefd[i][0], &count, sizeof(int)) != sizeof(int)) {
            print_err("error: cannot read from pipe\n");
            close(pipefd[i][0]);
            _exit(1);
        }
        close(pipefd[i][0]);
        res += count;
        active--;
    }
    close(fdr);
    for (int i = 0; i < P; ++i) {
        wait(NULL);
    }
    fdw = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, 0644);
    if (fdw < 0) {
        print_err("error: problem opening file to write\n");
        _exit(1);
    }
    sprintf(msg, "The character '%c' appears %d times in file %s.\n", c2c, res, argv[1]);
    write(fdw, msg, strlen(msg));
    close(fdw);
    return 0;
}
