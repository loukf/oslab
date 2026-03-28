#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include "config.h"

typedef struct {
    int pid;
    int pipefd1[2];
    int pipefd2[2];
} Worker;

int current_w = 0;
int res[2] = {0, 0};

int front_pipefd1[2];
int front_pipefd2[2];

int term(int n) {
    if (kill(getppid(), n == 0 ? SIGTERM : SIGINT) < 0) {
        if (errno != ESRCH) perror("kill");
    }
    _exit(n);
}

void sig_info_handler(int signum) {
    if (write(front_pipefd2[1], &current_w, sizeof(int)) != sizeof(int)) {
        perror("pipe_dispatcher");
        term(1);
    }
}

void sig_prog_handler(int signum) {
    if (write(front_pipefd2[1], &res, sizeof(res)) != sizeof(res)) {
        perror("pipe_dispatcher");
        term(1);
    }
}

pid_t exec_worker(const char *input, const char *c2c, Worker *w) {
    if ((pipe(w->pipefd1)) < 0) {
        perror("pipe_dispatcher");
        term(1);
    }
    if ((pipe(w->pipefd2)) < 0) {
        perror("pipe_dispatcher");
        term(1);
    }
    pid_t p = fork();
    if (p < 0) {
        perror("fork");
        term(1);
    } else if (p == 0) {
        close(front_pipefd1[0]);
        close(front_pipefd2[1]);
        close(w->pipefd1[1]);
        close(w->pipefd2[0]);
        char read[16], write[16];
        snprintf(read, sizeof(read), "%d", w->pipefd1[0]);
        snprintf(write, sizeof(write), "%d", w->pipefd2[1]);
        char *argv[6] = {"a1.4-worker", (char *)input, (char *)c2c, read, write, NULL};
        execv(argv[0], argv);
        perror("execv");
        term(127);
    }
    close(w->pipefd1[0]);
    close(w->pipefd2[1]);
    w->pid = p;
    current_w++;
    return p;
}

void cleanup_worker(Worker *w) {
    if (w->pid == -1) return;
    close(w->pipefd1[1]);
    close(w->pipefd2[0]);
    w->pid = -1;
    current_w--;
}

void kill_worker(Worker *w) {
    if (w->pid == -1) return ;
    if (kill(w->pid, SIGTERM) < 0) {
        if (errno != ESRCH) {
            perror("kill");
            term(1);
        }
    }
    int status;
    if (waitpid(w->pid, &status, 0) < 0) {
        if (errno != ECHILD) {
            perror("waitpid");
            term(1);
        }
    }
    cleanup_worker(w);
}

int reap_workers(Worker *workers) {
    int res = 0;
    int status;
    pid_t pid;
    for (int i = 0; i < MAX_W; i++) {
        if (workers[i].pid == -1) continue;
        pid = waitpid(workers[i].pid, &status, WNOHANG);
        if (pid == 0) continue;
        if (pid < 0 && errno != ECHILD) {
            perror("waitpid");
            term(1);
        }
        cleanup_worker(&workers[i]);
    }
    return res;
}

int assign_work(int *chunks, const int chunk_size, Worker *workers) {
    int result = 0;
    int busy = 0;
    for (int i = 0; i < CHUNK_NUM; ++i) {
        if (chunks[i] != 0) continue;
        while (busy < MAX_W && workers[busy].pid == -1) {
            busy++;
        }
        if (busy >= MAX_W) break;
        int offset = i*chunk_size;
        int at[2] = {offset, chunk_size};
        if (write(workers[busy].pipefd1[1], &at, sizeof(at)) != sizeof(at)) {
            if (errno != EPIPE && errno != EBADF) {
                perror("pipe_dispatcher");
                term(1);
            }
        }
        int x;
        if (read(workers[busy].pipefd2[0], &x, sizeof(int)) != sizeof(int)) {
            if (errno != EINTR && errno != EPIPE && errno == EBADF) {
                perror("pipe_dispatcher");
                term(1);
            }
        }
        chunks[i] = 1;
        result += x;
        busy++;
    }
    return result;
}

int calculate(const int *chunks, const int occur) {
    int done = 0;
    int flag = 1;
    for (int i = 0; i < CHUNK_NUM; ++i) {
        if (chunks[i] == 1) done++;
        else flag = 0;
    }
    res[0] = (done*100)/CHUNK_NUM;
    res[1] += occur;
    return flag;
}

void dispatch(const char *input, const char *c2c, Worker *workers) {
    static int flags_set = 0;
    if (!flags_set) {
        int flags = fcntl(front_pipefd1[0], F_GETFL, 0);
        fcntl(front_pipefd1[0], F_SETFL, flags | O_NONBLOCK);
        flags_set = 1;
    }
    int P;
    if (read(front_pipefd1[0], &P, sizeof(int)) != sizeof(int)) {
        if (errno != EINTR && errno != EWOULDBLOCK) {
            perror("pipe_dispatcher");
            term(1);
        }
        return;
    }
    if (P > 0) {
        int to_spawn = P;
        for (int i = 0; i < MAX_W && to_spawn > 0; ++i) {
            if (workers[i].pid > 0) continue;
            exec_worker(input, c2c, &workers[i]);
            to_spawn--;
        }
        if (to_spawn > 0) {
            fprintf(stderr, "(no more available workers - reached max value of %d)\n> ", MAX_W);
        }
    } else if (P < 0) {
        int to_kill = -P;
        for (int i = 0; i < MAX_W && to_kill > 0; ++i) {
            if (workers[i].pid == -1) continue;
            kill_worker(&workers[i]);
            to_kill--;
        }
    }
}

int main(int argc, char *argv[]) {
    if (argc != 5) {
        fprintf(stderr, "error: Bad dispatcher initialization\n");
        return 1;
    }
    char *endptr;
    front_pipefd1[0] = (int)strtol(argv[3], &endptr, 10);
    if (*endptr != '\0') {
        fprintf(stderr, "error: Invalid pipe FD: %s\n", argv[3]);
        return 1;
    }
    front_pipefd2[1] = (int)strtol(argv[4], &endptr, 10);
    if (*endptr != '\0') {
        fprintf(stderr, "error: Invalid pipe FD: %s\n", argv[4]);
        return 1;
    }
    struct sigaction sa_info;
    sa_info.sa_handler = sig_info_handler;
    sa_info.sa_flags = SA_RESTART;
    if (sigaction(SIGUSR1, &sa_info, NULL) < 0) {
        perror("sigaction");
        term(1);
    }
    struct sigaction sa_prog;
    sa_prog.sa_handler = sig_prog_handler;
    sa_prog.sa_flags = SA_RESTART;
    if (sigaction(SIGUSR2, &sa_prog, NULL) < 0) {
        perror("sigaction");
        term(1);
    }
    Worker workers[MAX_W];
    for (int i = 0; i < MAX_W; ++i) {
        workers[i].pid = -1;
    }
    int fdr;
    fdr = open(argv[1], O_RDONLY);
    if (fdr < 0) {
        perror("read");
        term(1);
    }
    long long end = lseek(fdr, 0, SEEK_END);
    if (end < 0) {
        perror("lseek");
        term(1);
    }
    off_t chunk_size = (end-1)/CHUNK_NUM+1;
    int chunks[CHUNK_NUM] = {0};
    int finish = 0;
    while (!finish) {
        reap_workers(workers);
        dispatch(argv[1], argv[2], workers);
        int occur = assign_work(chunks, chunk_size, workers);
        finish = calculate(chunks, occur);
    }
    fprintf(stdout, "Program finished!\nThe character '%c' appears %d times in file %s.\n", argv[2][0], res[1], argv[1]);
    term(0);
}
