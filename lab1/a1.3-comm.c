#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "utils.h"

#define WAIT_T 500 * 1000

char msg[1024];
int active = 0;
pid_t parent_pid;

void sighandler(int signum) {
    if (getpid() != parent_pid) return;
    snprintf(msg, sizeof(msg), "\nSIGINT: %3d child process(es) active\n", active);
    safe_write(1, msg, strlen(msg));
}

int main(int argc, char *argv[]) {
    if (argc != 4) {
        snprintf(msg, sizeof(msg), "Usage: %s <input-file> <output-file> <char>\n", argv[0]);
        safe_write(2, msg, strlen(msg));
        return 1;
    }
    sigset_t sigset;
    sigemptyset(&sigset);
    struct sigaction sa;
    sa.sa_handler = sighandler;
    sa.sa_flags = SA_RESTART;
    sa.sa_mask = sigset;
    if (sigaction(SIGINT, &sa, NULL) < 0) {
        snprintf(msg, sizeof(msg), "error: sigaction failed\n");
        safe_write(2, msg, strlen(msg));
        _exit(1);
    }
    parent_pid = getpid();
    int P = 13;
    int fdr, fdw;
    char c2c = argv[3][0];
    fdr = open(argv[1], O_RDONLY);
    if (fdr < 0) {
        snprintf(msg, sizeof(msg), "error: cannot open file to read\n");
        safe_write(2, msg, strlen(msg));
        _exit(1);
    }
    int pipefd[P][2];
    for (int i = 0; i < P; ++i) {
        if ((pipe(pipefd[i])) < 0) {
            snprintf(msg, sizeof(msg), "error: cannot create pipe\n");
            safe_write(2, msg, strlen(msg));
            _exit(1);
        }
    }
    struct stat st;
    if (fstat(fdr, &st) < 0) {
        snprintf(msg, sizeof(msg), "error: fstat failed\n");
        safe_write(2, msg, strlen(msg));
        exit(1);
    }
    off_t end = st.st_size;
    off_t chunk_size = (end-1)/P+1;
    for (int i = 0; i < P; ++i) {
        active++;
        pid_t p = fork();
        usleep(WAIT_T);
        if (p < 0) {
            snprintf(msg, sizeof(msg), "error: cannot fork process\n");
            safe_write(2, msg, strlen(msg));
            _exit(1);
        } else if (p == 0) {
            int child_count = 0;
            char buff[chunk_size+1];
            ssize_t rcnt;
            rcnt = safe_pread(fdr, buff, sizeof(buff)-1, chunk_size*i);
            if (rcnt == 0) /* end‐of‐file */
                break;
            if (rcnt < 0) { /* error */
                snprintf(msg, sizeof(msg), "error: cannot read from input file\n");
                safe_write(2, msg, strlen(msg));
                _exit(1);
            }
            for (int i = 0; i < rcnt; ++i) {
                if (buff[i] == c2c) {
                    child_count++;
                }
            }
            buff[rcnt] = '\0';
            // printf("Child %02d with PID %d: (%d)\t%s\n", i, getpid(), child_count, buff);
            if (safe_write(pipefd[i][1], &child_count, sizeof(int)) != sizeof(int)) {
                snprintf(msg, sizeof(msg), "error: cannot write to pipe\n");
                safe_write(2, msg, strlen(msg));
                close(pipefd[i][1]);
                _exit(1);
            }
            close(pipefd[i][1]);
            _exit(0);
        }
    }
    close(fdr);
    for (int i = 0; i < P; ++i) {
        close(pipefd[i][1]);
        wait(NULL);
    }
    int res = 0;
    for (int i = 0; i < P; ++i) {
        int count;
        if (read(pipefd[i][0], &count, sizeof(int)) != sizeof(int)) {
            snprintf(msg, sizeof(msg), "error: cannot read from pipe\n");
            safe_write(2, msg, strlen(msg));
            close(pipefd[i][0]);
            _exit(1);
        }
        close(pipefd[i][0]);
        res += count;
        active--;
    }
    fdw = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, 0644);
    if (fdw < 0) {
        snprintf(msg, sizeof(msg), "error: cannot write to pipe\n");
        safe_write(2, msg, strlen(msg));
        _exit(1);
    }
    snprintf(msg, sizeof(msg), "The character '%c' appears %d times in file %s.\n", c2c, res, argv[1]);
    safe_write(fdw, msg, strlen(msg));
    close(fdw);
    return 0;
}
