#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <string.h>

int active = 0;
pid_t parent_pid;

void sighandler(int signum) {
    if (getpid() != parent_pid) return;
    printf("\nSIGINT: %d child processes active.\n", active);
}

int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <input-file> <output-file> <char>\n", argv[0]);
        return 1;
    }
    struct sigaction sa;
    sa.sa_handler = sighandler;
    if (sigaction(SIGINT, &sa, NULL) < 0) {
        perror("sigaction");
        exit(1);
    }
    parent_pid = getpid();
    int P = 10;
    int fd, fdw;
    char c2c = argv[3][0];
    fd = open(argv[1], O_RDONLY);
    if (fd < 0) {
        perror("open");
        exit(1);
    }
    int pfd[P][2];
    for (int i = 0; i < P; ++i) {
        if ((pipe(pfd[i])) < 0) {
            perror("pipe");
            exit(1);
        }
    }
    off_t s = lseek(fd, 0, SEEK_END)-1;
    off_t size = (s-1)/P+1;
    int res = 0;
    pid_t p;
    for (int i = 0; i < P; ++i) {
        p = fork();
        active++;
        sleep(1);
        if (p < 0) {
            perror("fork");
            exit(1);
        } else if (p == 0) {
            int count = 0;
            char buff[size+1];
            ssize_t rcnt;
            rcnt = pread(fd,buff, sizeof(buff)-1, size*i);
            if (rcnt == 0) {} /* end‐of‐file */
            if (rcnt < 0) { /* error */
                perror("read");
                exit(1);
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
            perror("read from pipe");
        }
        res += child_count;
        active--;
    }
    char msg[1024];
    int len = snprintf(msg, sizeof(msg), "The character '%c' appears %d times in file %s.\n",
                       c2c, res, argv[1]);
    if (len >= sizeof(msg)) {
        fprintf(stderr, "Message too long\n");
        return 1;
    }
    fdw = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, 0644);
    if (fdw < 0) {
        perror("open");
        exit(1);
    }
    write(fdw, msg, len);
    close(fd);
    close(fdw);
}
