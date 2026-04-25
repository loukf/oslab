#include <unistd.h>
#include <errno.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "defines.h"

pid_t p;
int pipefd1[2];
int pipefd2[2];

void sigchld_handler(int signum) {
    int status;
    pid_t pid;
    if ((pid = waitpid(p, &status, WNOHANG)) < 0) {
        perror("wait");
        _exit(1);
    }
    if (pid != p) {
        return;
    }
    if (WIFSIGNALED(status)) {
        write(1, "\n", 1);
        _exit(WTERMSIG(status));
    } else if (WIFEXITED(status)) {
        _exit(WEXITSTATUS(status));
    }
}

int ext(int n) {
    if (kill(p, 9) < 0) {
        perror("kill");
        exit(-1);
    }
    exit(n);
}

int parse(const char *s) {
    while (*s == ' ' || *s == '\t') s++;
    if (*s == '\n') {
        return 0;
    }
    while (*s != '\n' && *s != '\0') s++;
    if (*s == '\0') {
        fprintf(stdout, "\n");
        ext(0);
    }
    return 1;
}

int parse_with_arg(const char *s, int *x_out) {
    if (*s != ' ' && *s != '\t' && *s != '\n' && *s != '\0') {
        return 1;
    }
    while (*s == ' ' || *s == '\t') s++;
    if (*s == '\0') {
        fprintf(stdout, "\n");
        ext(0);
    }
    if (*s == '\n') {
        return 2;
    }
    char *endptr;
    int x = (int)strtol(s, &endptr, 10);
    if (parse(&endptr[0])) {
        return 3;
    }
    if (x < 0) {
        return 4;
    }
    *x_out = x;
    return 0;
}

void show_pstree(pid_t p) {
    int ret;
    char cmd[CHUNK_MSG];
    snprintf(cmd, sizeof(cmd), "echo; pstree -a -G -c -p %ld; echo", (long)p);
    cmd[sizeof(cmd)-1] = '\0';
    ret = system(cmd);
    if (ret < 0) {
        perror("system");
        ext(104);
    }
}

void print_worker_list(const int res[MAX_WORKERS][2]) {
    int idle = 0;
    int busy = 0;
    fprintf(stdout, "┌───────────┬────────────┬───────┐\n");
    fprintf(stdout, "│ WORKER ID │ WORKER PID │ CHUNK │\n");
    fprintf(stdout, "├───────────┼────────────┼───────┤\n");
    for (int i = 0; i < MAX_WORKERS; ++i) {
        if (res[i][0] == -1) {
            continue;
        }
        fprintf(stdout, "│ %9d │ %10d │", i, res[i][0]);
        if (res[i][1] == -1) {
            idle++;
            fprintf(stdout, " %5s │\n", "-");
        } else {
            busy++;
            fprintf(stdout, " %5d │\n", res[i][1]);
        }
    }
    fprintf(stdout, "└───────────┴────────────┴───────┘\n");
    fprintf(stdout, "\nConcurrent workers: %d (%d Busy, %d Idle)\n", busy+idle, busy, idle);
}

void help(void) {
    fprintf(stdout, 
            "Available commands:\n"
            "   add <x>\tadd x workers (search processes)\n"
            "   sub <x>\tremove x workers\n"
            "   info\t\tdisplay information about active workers\n"
            "   prog\t\tshow current search progress\n"
            "   help\t\tdisplay this help message\n"
            "   exit\t\texit the program\n");
}                     

void add(const int x) {
    if (write(pipefd1[1], &x, sizeof(int)) != sizeof(int)) {
        perror("pipe_frontend");
        ext(1);
    }
}

void info(void) {
    if (kill(p, SIGUSR1) < 0) {
        perror("kill");
        ext(-1);
    }
    int x;
    if (read(pipefd2[0], &x, sizeof(int)) != sizeof(int)) {
        perror("pipe_frontend");
        ext(1);
    }
    if (x == 0) {
        fprintf(stdout, "Concurrent workers: %d\n", x);
        return;
    }
    int res[MAX_WORKERS][2];
    if (read(pipefd2[0], &res, sizeof(res)) != sizeof(res)) {
        perror("pipe_frontend");
        ext(1);
    }
    print_worker_list(res);
}

void prog(const char *input, const char *c2c) {
    int res[3];
    if (kill(p, SIGUSR2) < 0) {
        perror("kill");
        ext(1);
    }
    if (read(pipefd2[0], &res, sizeof(res)) != sizeof(res)) {
        perror("pipe_frontend");
        ext(1);
    }
    double percent = ((double)res[0] / (double)res[1]) * 100.0;
    fprintf(stdout, "Progress: %.2f%% - %d instances of the character '%s' found so far in %s\n", percent, res[2], c2c, input);
}

void create_dispatcher(const char *input, const char *c2c) {
    close(pipefd1[1]);
    close(pipefd2[0]);
    char read[16], write[16];
    snprintf(read, sizeof(read), "%d", pipefd1[0]);
    snprintf(write, sizeof(write), "%d", pipefd2[1]);
    char *argv[6] = {"a1.4-dispatcher", (char *)input, (char *)c2c, read, write, NULL};
    execv(argv[0], argv);
    perror("execv");
    _exit(127);
}

void read_input(const char *input, const char *c2c) {
    write(1, "> ", 2);
    ssize_t rcnt;
    char buff[CHUNK_MSG];
    rcnt = read(0, buff, sizeof(buff)-1);
    if (rcnt == 0) { /* end-of-file */
        fprintf(stdout, "\n");
        ext(0);
    }
    if (rcnt < 0) { /* error */
        perror("read");
        ext(1);
    }
    buff[rcnt] = '\0';
    int x, res;
    char *s = &buff[0];
    while (*s == ' ' || *s == '\t') s++;
    if (*s == '\n') {
        return;
    } else if (*s == '\0') {
        fprintf(stdout, "\n");
        ext(0); 
    } else if (strncmp(s, "add", 3) == 0) {
        if (!(res = parse_with_arg(&s[3], &x))) {
            add(x);
        }
    } else if (strncmp(s, "sub", 3) == 0) {
        if (!(res = parse_with_arg(&s[3], &x))) {
            add(-x);
        }
    } else if (strncmp(s, "exit", 4) == 0) {
        if (!(res = parse(&s[4]))) {
            ext(0);
        }
    } else if (strncmp(s, "info", 4) == 0) {
        if (!(res = parse(&s[4]))) {
            info();
        }
    } else if (strncmp(s, "prog", 4) == 0) {
        if (!(res = parse(&s[4]))) {
            prog(input, c2c);
        }
    } else if (strncmp(s, "help", 4) == 0) {
        if (!(res = parse(&s[4]))) {
            help();
        }
    } else if (strncmp(s, "ps", 2) == 0) {
        if (!(res = parse(&s[2]))) {
            show_pstree(getpid());
        }
    } else {
        res = parse(&s[0]);
    }
    switch (res) {
        case 1:
            fprintf(stderr, "Unknown command. Type 'help' to see the available commands\n");
            break;
        case 2:
            fprintf(stderr, "Please provide a number of workers\n");
            break;
        case 3:
            fprintf(stderr, "Invalid number of workers\n");
            break;
        case 4:
            fprintf(stderr, "Number must be non-negative\n");
            break;
    }
}

const char *trim_char(const char *s) {
    if (!s[0]) {
        return NULL;
    }
    static char c2c[3];
    if (s[0] == '\\') {
        if (s[1] == '0') {
            return NULL;
        }
        if (s[1] == 'n' || s[1] == 't' || s[1] == 'b') {
            c2c[0] = s[0];
            c2c[1] = s[1];
            c2c[2] = '\0';
            return c2c;
        }
    }
    c2c[0] = s[0];
    c2c[1] = '\0';
    return c2c;
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <input-file> <char>\n", argv[0]);
        return 1;
    }
    const char *c2c = trim_char(argv[2]);
    if (c2c == NULL) {
        fprintf(stderr, "Error: forbidden character: '%s'\n", argv[2]);
        return 1;
    }
    if ((pipe(pipefd1)) < 0) {
        perror("pipe_frontend");
        exit(1);
    }
    if ((pipe(pipefd2)) < 0) {
        perror("pipe_frontend");
        exit(1);
    }
    struct sigaction sa;
    sigset_t sigset;
    sa.sa_handler = sigchld_handler;
    sa.sa_flags = SA_RESTART;
    sa.sa_mask = sigset;
    if (sigaction(SIGCHLD, &sa, NULL) < 0) {
        perror("sigaction");
        exit(1);
    }
    p = fork();
    if (p < 0) {
        perror("fork");
        exit(1);
    } else if (p == 0) {
        create_dispatcher(argv[1], c2c);
    }
    close(pipefd1[0]);
    close(pipefd2[1]);
    for (;;) {
        read_input(argv[1], c2c);
    }
}
