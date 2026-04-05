#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include "config.h"

typedef struct {
    int pid;
    int status;
    int pipefd1[2];
    int pipefd2[2];
} Worker;

int current_workers = 0;
int res[3] = {0, 0, 0};

int front_pipefd1[2];
int front_pipefd2[2];

void sig_info_handler(int signum) {
    if (write(front_pipefd2[1], &current_workers, sizeof(int)) != sizeof(int)) {
        perror("pipe_dispatcher");
        exit(1);
    }
}

void sig_prog_handler(int signum) {
    if (write(front_pipefd2[1], &res, sizeof(res)) != sizeof(res)) {
        perror("pipe_dispatcher");
        exit(1);
    }
}

pid_t exec_worker(const int fdr, const char *c2c, Worker *w) {
    if ((pipe(w->pipefd1)) < 0) {
        perror("pipe_dispatcher");
        exit(1);
    }
    if ((pipe(w->pipefd2)) < 0) {
        perror("pipe_dispatcher");
        exit(1);
    }
    pid_t p = fork();
    if (p < 0) {
        perror("fork");
        exit(1);
    } else if (p == 0) {
        close(front_pipefd1[0]);
        close(front_pipefd2[1]);
        close(w->pipefd1[1]);
        close(w->pipefd2[0]);
        char read[16], write[16], fdr_str[16];
        snprintf(read, sizeof(read), "%d", w->pipefd1[0]);
        snprintf(write, sizeof(write), "%d", w->pipefd2[1]);
        snprintf(fdr_str, sizeof(fdr_str), "%d", fdr);
        char *argv[6] = {"a1.4-worker", fdr_str, (char *)c2c, read, write, NULL};
        execv(argv[0], argv);
        perror("execv");
        _exit(127);
    }
    close(w->pipefd1[0]);
    close(w->pipefd2[1]);
    int flags = fcntl(w->pipefd2[0], F_GETFL, 0);
    if (flags == -1) {
        perror("fcntl F_GETFL");
        exit(1);
    }
    if (fcntl(w->pipefd2[0], F_SETFL, flags | O_NONBLOCK) == -1) {
        perror("fcntl F_SETFL");
        exit(1);
    }
    w->pid = p;
    w->status = -1;
    current_workers++;
    return p;
}

void cleanup_worker(Worker *w, int *chunks) {
    if (w->pid == -1) {
        return;
    }
    close(w->pipefd1[1]);
    close(w->pipefd2[0]);
    chunks[w->status] = 0;
    w->pid = -1;
    w->status = -1;
    current_workers--;
}

void kill_worker(Worker *w, int *chunks) {
    if (w->pid == -1) {
        return ;
    }
    if (kill(w->pid, SIGTERM) < 0) {
        if (errno != ESRCH) {
            perror("kill");
            exit(1);
        }
    }
    int status;
    if (waitpid(w->pid, &status, 0) < 0) {
        if (errno != ECHILD) {
            perror("waitpid");
            exit(1);
        }
    }
    cleanup_worker(w, chunks);
}

void reap_workers(Worker *workers, int *chunks) {
    int status;
    for (int i = 0; i < MAX_W; i++) {
        if (workers[i].pid == -1) {
            continue;
        }
        pid_t pid = waitpid(workers[i].pid, &status, WNOHANG);
        if (pid == 0) {
            continue;
        }
        if (pid < 0 && errno != ECHILD) {
            perror("waitpid");
            exit(1);
        }
        cleanup_worker(&workers[i], chunks);
    }
}

void dispatch(const int fdr, const char *c2c, Worker *workers, int *chunks) {
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
            exit(1);
        }
        return;
    }
    if (P > 0) {
        int to_spawn = P;
        for (int i = 0; i < MAX_W && to_spawn > 0; ++i) {
            if (workers[i].pid > 0) {
                continue;
            }
            exec_worker(fdr, c2c, &workers[i]);
            to_spawn--;
        }
        if (to_spawn > 0) {
            fprintf(stderr, "(reached maximum worker limit of %d - cannot add any more workers)\n", MAX_W);
        }
    } else if (P < 0) {
        int to_kill = -P;
        for (int i = 0; i < MAX_W && to_kill > 0; ++i) {
            if (workers[i].pid == -1 || workers[i].status == -1) {
                continue;
            }
            kill_worker(&workers[i], chunks);
            to_kill--;
        }
        for (int i = 0; i < MAX_W && to_kill > 0; ++i) {
            if (workers[i].pid == -1) {
                continue;
            }
            kill_worker(&workers[i], chunks);
            to_kill--;
        }
        if (to_kill > 0) {
            fprintf(stderr, "(reached minimum worker limit of 0 - cannot remove any more workers)\n");
        }
    }
}

void assign_work(Worker *workers, int *chunks, const int chunk_size) {
    int checked = 0;
    for (int i = 0; i < res[1]; ++i) {
        if (chunks[i] != 0) {
            continue;
        }
        while (checked < MAX_W && (workers[checked].pid == -1 || workers[checked].status != -1)) checked++;
        if (checked >= MAX_W) {
            break;
        }
        int at[2] = {i, chunk_size};
        if (write(workers[checked].pipefd1[1], &at, sizeof(at)) != sizeof(at)) {
            if (errno == EPIPE) {
                cleanup_worker(&workers[checked], chunks);
                checked++;
                i--;
                continue;
            }
            perror("pipe_dispatcher");
            exit(1);
        }
        workers[checked].status = i;
        chunks[i] = 1;
        checked++;
    }
}

void read_result(Worker *workers, int *chunks) {
    for (int i = 0; i < MAX_W; ++i) {
        if (workers[i].pid == -1 || workers[i].status == -1)  {
            continue;
        }
        int at[2];
        if (read(workers[i].pipefd2[0], &at, sizeof(at)) != sizeof(at)) {
            if (errno != EINTR && errno != EWOULDBLOCK) {
                perror("pipe_dispatcher");
                exit(1);
            }
            continue;
        }
        workers[i].status = -1;
        chunks[at[0]] = 2;
        res[2] += at[1];
        res[0]++;
    }
}

int init_chunks(off_t end) {
    res[1] = end < CHUNK_NUM ? end : CHUNK_NUM;
    return (end-1)/res[1]+1;
}

int main(int argc, char *argv[]) {
    if (argc != 5) {
        fprintf(stdout, "error: Bad dispatcher initialization\n");
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
        exit(1);
    }
    struct sigaction sa_prog;
    sa_prog.sa_handler = sig_prog_handler;
    sa_prog.sa_flags = SA_RESTART;
    if (sigaction(SIGUSR2, &sa_prog, NULL) < 0) {
        perror("sigaction");
        exit(1);
    }
    int fdr;
    fdr = open(argv[1], O_RDONLY);
    if (fdr < 0) {
        perror("read");
        exit(1);
    }
    struct stat st;
    if (fstat(fdr, &st) < 0) {
        perror("fstat");
        exit(1);
    }
    int chunk_size = init_chunks(st.st_size);
    int chunks[CHUNK_NUM] = {0};
    Worker workers[MAX_W];
    for (int i = 0; i < MAX_W; ++i) {
        workers[i].pid = -1;
    }
    while (res[0] < res[1]) {
        reap_workers(workers, chunks);
        read_result(workers, chunks);
        dispatch(fdr, argv[2], workers, chunks);
        assign_work(workers, chunks, chunk_size);
        usleep(LOOP_WAIT);
    }
    close(fdr);
    fprintf(stdout, "Program finished!\n");
    fprintf(stdout, "The character '%c' appears %d times in file %s.\n", argv[2][0], res[2], argv[1]);
}
