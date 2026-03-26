#include <unistd.h>
#include <signal.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>

int workers = 0;
int occur = 79;
int percent = 11;

int pipefd1[2];
int pipefd2[2];

void sig_info_handler(int signum) {
    int x = workers;
    if (write(pipefd2[1], &x, sizeof(int)) != sizeof(int)) {
        perror("pipe");
        _exit(1);
    }
}

void sig_prog_handler(int signum) {
    int res[2];
    res[0] = percent;
    res[1] = occur;
    if (write(pipefd2[1], &res, 2*sizeof(int)) != 2*sizeof(int)) {
        perror("pipe");
        _exit(1);
    }
}

int main(int argc, char *argv[]) {
    if (argc != 5) {
        fprintf(stderr, "error: Bad dispatcher initialization\n");
        return 1;
    }
    char *endptr;
    pipefd1[0] = (int)strtol(argv[3], &endptr, 10);
    pipefd2[1] = (int)strtol(argv[4], &endptr, 10);
    if (*endptr != '\0') {
        fprintf(stderr, "error: Invalid pipe FD: %s\n");
        return 1;
    }
    struct sigaction sa_info;
    sa_info.sa_handler = sig_info_handler;
    if (sigaction(SIGUSR1, &sa_info, NULL) < 0) {
        perror("sigaction");
        exit(1);
    }
    struct sigaction sa_prog;
    sa_prog.sa_handler = sig_prog_handler;
    if (sigaction(SIGUSR2, &sa_prog, NULL) < 0) {
        perror("sigaction");
        exit(1);
    }
    while (1) {
        int x = 0;
        if (read(pipefd1[0], &x, sizeof(int)) != sizeof(int)) {
            if (errno != EINTR) {
                perror("pipe");
                _exit(1);
            }
        } else {
            if (x > 0) {
                for (int i = 0; i < x; ++i) {
                    pid_t p = fork();
                    /*
                     * Must keep worker list instead of single p
                     */
                    if (p < 0) {
                        perror("fork");
                        _exit(1);
                    } else if (p == 0) {
                        execv("a1.4-worker", argv);
                        perror("execv");
                        _exit(127);
                    }
                    /*
                     * Do dispatcher stuff
                     */
                }
            } else if (x < 0) {
                x = workers > -x ? x : -workers;
                for (int i = 0; i < -x; ++i) {
                    /*
                     * Kill x workers
                     */
                }
            }
        }
        workers += x;
    }
}
