#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "utils.h"

char msg[1024];

int main(int argc, char *argv[]) {
    if (argc != 4) {
        snprintf(msg, sizeof(msg), "Usage: %s <input-file> <output-file> <char>\n", argv[0]);
        safe_write(2, msg, strlen(msg));
        return 1;
    }
    int fdr, fdw;
    char c2c = argv[3][0];
    fdr = open(argv[1], O_RDONLY);
    if (fdr < 0) {
        snprintf(msg, sizeof(msg), "error: cannot open file to read\n");
        safe_write(2, msg, strlen(msg));
        _exit(1);
    }
    int pipefd[2];
    if ((pipe(pipefd)) < 0) {
        snprintf(msg, sizeof(msg), "error: cannot create pipe\n");
        safe_write(2, msg, strlen(msg));
        _exit(1);
    }
    int x;
    pid_t p = fork();
    if (p < 0) {
        snprintf(msg, sizeof(msg), "error: cannot fork process\n");
        safe_write(2, msg, strlen(msg));
        _exit(1);
    } else if (p == 0) {
        snprintf(msg, sizeof(msg), "Hello from child with PID=%d, Parent PID=%d.\n", getpid(), getppid());
        safe_write(1, msg, strlen(msg));
        x = 42;
        close(pipefd[0]);
        int child_count = 0;
        char buff[1024];
        ssize_t rcnt;
        for (;;) {
            rcnt = read(fdr, buff, sizeof(buff)-1);
            if (rcnt == 0) /* end‐of‐file */
                break;
            if (rcnt < 0) { /* error */
                snprintf(msg, sizeof(msg), "error: cannot read from input file\n");
                safe_write(2, msg, strlen(msg));
                _exit(1);
            }
            for (int i = 0; i < rcnt; i++) {
                if (buff[i] == c2c) {
                    child_count++;
                }
            }
        }
        close(fdr);
        if (write(pipefd[1], &child_count, sizeof(int)) != sizeof(int)) {
            snprintf(msg, sizeof(msg), "error: cannot write to pipe\n");
            safe_write(2, msg, strlen(msg));
            close(pipefd[1]);
            _exit(1);
        }
        close(pipefd[1]);
    } else {
        close(fdr);
        close(pipefd[1]);
        wait(NULL);
        snprintf(msg, sizeof(msg), "Child with PID=%d finished.\n", p);
        safe_write(1, msg, strlen(msg));
        x = 67;
        int count;
        if (read(pipefd[0], &count, sizeof(int)) != sizeof(int)) {
            snprintf(msg, sizeof(msg), "error: cannot read from pipe\n");
            safe_write(2, msg, strlen(msg));
            close(pipefd[0]);
            _exit(1);
        }
        close(pipefd[0]);
        fdw = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, 0644);
        if (fdw < 0) {
            snprintf(msg, sizeof(msg), "error: cannot open file to write\n");
            safe_write(2, msg, strlen(msg));
            _exit(1);
        }
        snprintf(msg, sizeof(msg), "The character '%c' appears %d times in file %s.\n", c2c, count, argv[1]);
        safe_write(fdw, msg, strlen(msg));
        close(fdw);
    }
    snprintf(msg, sizeof(msg), "%d\n", x);
    safe_write(1, msg, strlen(msg));
    return 0;
}
