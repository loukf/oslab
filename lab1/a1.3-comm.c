#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <string.h>

char msg[1024];
int active = 0;
pid_t parent_pid;

void print_err(const char *s) {
    write(2, s, strlen(s));
}

void sighandler(int signum) {
    if (getpid() != parent_pid) return;
    sprintf(msg, "\nSIGINT: %d child processes active.\n", active);
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
    if (sigaction(SIGINT, &sa, NULL) < 0) {
        print_err("Error: sigaction failed\n");
        _exit(1);
    }
    parent_pid = getpid();
    int P = 10;
    int fdr, fdw;
    char c2c = argv[3][0];
    fdr = open(argv[1], O_RDONLY);
    if (fdr < 0) {
        print_err("Error: cannot open file to read\n");
        _exit(1);
    }
    int pfd[P][2];
    for (int i = 0; i < P; ++i) {
        if ((pipe(pfd[i])) < 0) {
            print_err("Error: cannot create pipe\n");
            _exit(1);
        }
    }
    off_t s = lseek(fdr, 0, SEEK_END)-1;
    off_t size = (s-1)/P+1;
    int res = 0;
    pid_t p;
    for (int i = 0; i < P; ++i) {
        p = fork();
        active++;
        sleep(1);
        if (p < 0) {
            print_err("Error: cannot fork process\n");
            _exit(1);
        } else if (p == 0) {
            int count = 0;
            char buff[size+1];
            ssize_t rcnt;
            rcnt = pread(fdr, buff, sizeof(buff)-1, size*i);
            if (rcnt == 0) {} /* end‐of‐file */
            if (rcnt < 0) { /* error */
                print_err("Eror: problem reading from input file\n");
                _exit(1);
            }
            buff[rcnt] = '\0';
            for (int i = 0; i < rcnt; i++) {
                if (buff[i] == c2c) {
                    count++;
                }
            }
            // printf("Child %d with PID %d:\t(%d)\t%s\n", i, getpid(), count, buff);
            write(pfd[i][1], &count, sizeof(int));
            return 0;
        }
    }
    int child_count;
    for (int i = 0; i < P; ++i) {
        wait(NULL);
        if (read(pfd[i][0], &child_count, sizeof(int)) != sizeof(int)) {
            print_err("Error: cannot read from pipe\n");
            _exit(1);
        }
        res += child_count;
        active--;
    }
    close(fdr);
    sprintf(msg, "The character '%c' appears %d times in file %s.\n", c2c, res, argv[1]);
    fdw = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, 0644);
    if (fdw < 0) {
        print_err("Error: problem opening file to write\n");
        _exit(1);
    }
    write(fdw, msg, strlen(msg));
    close(fdw);
    return 0;
}
