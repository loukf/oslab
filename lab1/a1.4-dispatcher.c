#include <unistd.h>
#include <signal.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>

int workers = 0;
int occur = 79;
int percent = 11;

int pipefd1[2];
int pipefd2[2];

pid_t pid[1024];

// void sig_int_handler(int signum) {
//     for (int i = 0; i < workers; ++i) {
//         kill(pid[i], SIGTERM);
//     }
    // while (wait(NULL) > 0);
}

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
    // struct sigaction sa;
    // sa.sa_handler = sig_int_handler;
    // if (sigaction(SIGINT, &sa, NULL) < 0) {
    //     perror("sigaction");
    //     exit(1);
    // }
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
        while (waitpid(-1, NULL, WNOHANG) > 0) {
            workers--;
        }
        int x = 0;
        if (read(pipefd1[0], &x, sizeof(int)) != sizeof(int)) {
            if (errno != EINTR) {
                perror("pipe");
                _exit(1);
            }
        } else if (x > 0) {
            for (int i = 0; i < x; ++i) {
                pid_t p = fork();
                if (p < 0) {
                    perror("fork");
                    _exit(1);
                } else if (p == 0) {
                    close(pipefd1[0]);
                    close(pipefd2[1]);
                    argv[0] = "a1.4-worker";
                    argv[3] = "67";
                    argv[4] = NULL;
                    execv(argv[0], argv);
                    perror("execv");
                    _exit(127);
                }
                pid[workers+i] = p;
                /*
                 * Do dispatcher stuff
                 */
            }
        } else if (x < 0) {
            int y = -x;
            if (y > workers) y = workers;
            y = workers > y ? y : workers;
            x = -y;
            for (int i = 0; i < y; ++i) {
                if (kill(pid[workers - i - 1], 9) < 0) {
                    perror("kill");
                    exit(1);
                }
            }
            workers -= y;
            continue;
        }
        workers += x;
    }
}
