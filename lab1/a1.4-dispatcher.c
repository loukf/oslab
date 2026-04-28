#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include "defines.h"

struct worker {
    int pid;
    int status;
    int pipefd1[2];
    int pipefd2[2];
};

struct chunk {
    int occur;
    int status;
};

struct program_state {
    int chunk_size;
    int checked_chunks;
    int total_chunks;
    int total_occur;
};

int sig_info = 0;
int sig_prog = 0;

int front_pipefd1[2];
int front_pipefd2[2];

void sig_info_handler(int signum) {
    sig_info = 1;
}

void sig_prog_handler(int signum) {
    sig_prog = 1;
}

void send_info(const struct worker *workers) {
    int current_workers = 0;
    for (int i = 0; i < MAX_WORKERS; ++i) {
        if (workers[i].pid != -1) {
            current_workers++;
        }
    }
    if (write(front_pipefd2[1], &current_workers, sizeof(int)) != sizeof(int)) {
        perror("pipe_dispatcher");
        _exit(1);
    }
    if (current_workers == 0) {
        return;
    }
    int buff[MAX_WORKERS][2];
    for (int i = 0; i < MAX_WORKERS; ++i) {
        buff[i][0] = workers[i].pid;
        buff[i][1] = workers[i].status;
    }
    if (write(front_pipefd2[1], &buff, sizeof(buff)) != sizeof(buff)) {
        perror("pipe_dispatcher");
        _exit(1);
    }
}

void send_prog(const struct program_state *state) {
    int res[3] = { state->checked_chunks, state->total_chunks, state->total_occur };
    if (write(front_pipefd2[1], &res, sizeof(res)) != sizeof(res)) {
        perror("pipe_dispatcher");
        _exit(1);
    }
}

void spawn_worker(const int fdr, const char *c2c, struct worker *w) {
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
}

void kill_worker(struct worker *w) {
    if (w->pid == -1) {
        return ;
    }
    if (kill(w->pid, SIGTERM) < 0) {
        if (errno != ESRCH) {
            perror("kill");
            exit(1);
        }
    }
}

void cleanup_workers(struct chunk *chunks, struct worker *workers) {
    for (int i = 0; i < MAX_WORKERS; i++) {
        if (workers[i].pid == -1) {
            continue;
        }
        int status;
        pid_t pid = waitpid(workers[i].pid, &status, WNOHANG);
        if (pid == 0) {
            continue;
        }
        if (pid < 0 && errno != ECHILD) {
            perror("waitpid");
            exit(1);
        }
        close(workers[i].pipefd1[1]);
        close(workers[i].pipefd2[0]);
        if (workers[i].status != -1) {
            chunks[workers[i].status].status = -1;
        }
        workers[i].pid = -1;
        workers[i].status = -1;
    }
}

void read_result(struct chunk *chunks, struct worker *workers, struct program_state *state) {
    for (int i = 0; i < MAX_WORKERS; ++i) {
        if (workers[i].pid == -1 || workers[i].status == -1)  {
            continue;
        }
        int x;
        if (read(workers[i].pipefd2[0], &x, sizeof(int)) != sizeof(int)) {
            if (errno != EINTR && errno != EWOULDBLOCK) {
                perror("pipe_dispatcher");
                exit(1);
            }
            continue;
        }
        int j = workers[i].status;
        chunks[j].occur = x;
        chunks[j].status = 1;
        workers[i].status = -1;
        state->total_occur += x;
        state->checked_chunks++;
    }
}

void assign_work(struct chunk *chunks, struct worker *workers, const struct program_state *state ) {
    int j = 0;
    for (int i = 0; i < state->total_chunks; ++i) {
        if (chunks[i].status != -1) {
            continue;
        }
        while (j < MAX_WORKERS && (workers[j].pid == -1 || workers[j].status != -1)) j++;
        if (j >= MAX_WORKERS) {
            break;
        }
        int at[2] = {i, state->chunk_size};
        if (write(workers[j].pipefd1[1], &at, sizeof(at)) != sizeof(at)) {
            if (errno != EPIPE) {
                perror("pipe_dispatcher");
                exit(1);
            }
            j++;
            i--;
            continue;
        }
        workers[j].status = i;
        chunks[i].status = 0;
        j++;
    }
}

void dispatch(const int fdr, const char *c2c, struct worker *workers) {
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
        for (int i = 0; i < MAX_WORKERS && to_spawn > 0; ++i) {
            if (workers[i].pid > 0) {
                continue;
            }
            spawn_worker(fdr, c2c, &workers[i]);
            to_spawn--;
        }
        if (to_spawn > 0) {
            fprintf(stderr, "\b\b[Dispatcher] cannot add more workers - already at maximum (%d)\n> ", MAX_WORKERS);
        }
    } else if (P < 0) {
        int to_kill = -P;
        for (int i = MAX_WORKERS-1; i >= 0 && to_kill > 0; --i) {
            if (workers[i].pid == -1) {
                continue;
            }
            kill_worker(&workers[i]);
            to_kill--;
        }
        if (to_kill > 0) {
            fprintf(stderr, "\b\b[Dispatcher] cannot remove more workers - already at minimum (0)\n> ");
        }
    }
}

struct program_state init_state(const off_t end) {
    struct program_state state;
    state.checked_chunks = 0;
    state.total_occur = 0;
    if (end < 10*CHUNK_BIG) {
        state.chunk_size = CHUNK_SMALL;
    } else {
        state.chunk_size = CHUNK_BIG;
    }
    state.total_chunks = (end-1) / state.chunk_size + 1;
    return state;
}

const char *decode(const char *s) {
    static char c2c[2];
    if (s[0] == '\\') {
        switch(s[1]) {
            case 'n':
                c2c[0] = '\n';
                break;
            case 't':
                c2c[0] = '\t';
                break;
            case 'b':
                c2c[0] = '\b';
                break;
            default:
                c2c[0] = '\\';
        }
    } else {
        c2c[0] = s[0];
    }
    c2c[1] = '\0';
    return c2c;
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
    sigset_t sigset;
    sigemptyset(&sigset);
    struct sigaction sa_info;
    sa_info.sa_handler = sig_info_handler;
    sa_info.sa_flags = SA_RESTART;
    sa_info.sa_mask = sigset;
    if (sigaction(SIGUSR1, &sa_info, NULL) < 0) {
        perror("sigaction");
        exit(1);
    }
    struct sigaction sa_prog;
    sa_prog.sa_handler = sig_prog_handler;
    sa_prog.sa_flags = SA_RESTART;
    sa_prog.sa_mask = sigset;
    if (sigaction(SIGUSR2, &sa_prog, NULL) < 0) {
        perror("sigaction");
        exit(1);
    }
    int flags = fcntl(front_pipefd1[0], F_GETFL, 0);
    if (flags == -1) {
        perror("fcntl GETFL");
        exit(1);
    }
    if (fcntl(front_pipefd1[0], F_SETFL, flags | O_NONBLOCK) == -1) {
        perror("fcntl SETFL");
        exit(1);
    }
    int fdr;
    fdr = open(argv[1], O_RDONLY);
    if (fdr < 0) {
        perror("open");
        exit(1);
    }
    struct stat st;
    if (fstat(fdr, &st) < 0) {
        perror("fstat");
        exit(1);
    }
    if (st.st_size == 0) {
        fprintf(stderr, "error: Empty file\n");
        close(fdr);
        return 1;
    }
    const char *c2c = decode(argv[2]);
    struct program_state state = init_state(st.st_size);
    struct chunk chunks[state.total_chunks];
    for (int i = 0; i < state.total_chunks; ++i) {
        chunks[i].status = -1;
    }
    struct worker workers[MAX_WORKERS];
    for (int i = 0; i < MAX_WORKERS; ++i) {
        workers[i].pid = -1;
    }
    while (state.checked_chunks < state.total_chunks) {
        if (sig_info) {
            send_info(workers);
            sig_info = 0;
        }
        if (sig_prog) {
            send_prog(&state);
            sig_prog = 0;
        }
        cleanup_workers(chunks, workers);
        read_result(chunks, workers, &state);
        assign_work(chunks, workers, &state);
        dispatch(fdr, c2c, workers);
        usleep(LOOP_WAIT);
    }
    close(fdr);
    fprintf(stdout, "Program finished!\n");
    fprintf(stdout, "The character '%s' appears %d times in %s.\n", argv[2], state.total_occur, argv[1]);
}
