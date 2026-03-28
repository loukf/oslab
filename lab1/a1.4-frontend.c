#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "config.h"

pid_t p;
int pipefd1[2];
int pipefd2[2];

void sighandler(int signum) {
    _exit(0);
}

void show_pstree(pid_t p) {
    int ret;
    char cmd[CHUNK];
    snprintf(cmd, sizeof(cmd), "echo; pstree -a -G -c -p %ld; echo",
            (long)p);
    cmd[sizeof(cmd)-1] = '\0';
    ret = system(cmd);
    if (ret < 0) {
        perror("system");
        exit(104);
    }
}

int check(char *s) {
    while (*s == ' ' || *s == '\t') s++;
    if (*s == '\n' || *s == '\0') {
        return 0;
    }
    fprintf(stderr, "Unknown command. Type 'help' to see the available commands\n");
    return 1;
}

void help() {
    fprintf(stdout,
            "Available commands:\n"
            "   add <x>\tadd x workers (search processes)\n"
            "   rm  <x>\tremove x workers\n"
            "   info\t\tdisplay information about active workers\n"
            "   prog\t\tshow current search progress\n"
            "   help\t\tdisplay this help message\n"
            "   exit\t\texit the program\n");
}                     

int ext() {
    if (kill(p, 2) < 0) {
        perror("kill");
        return -1;
    }
    return 0;
}

int add(const int x) {
    if (write(pipefd1[1], &x, sizeof(int)) != sizeof(int)) {
        perror("pipe_frontend");
        _exit(1);
    }
    return 0;
}

int info() {
    int x;
    if (kill(p, SIGUSR1) < 0) {
        perror("kill");
        return -1;
    }
    if (read(pipefd2[0], &x, sizeof(int)) != sizeof(int)) {
        perror("pipe_frontend");
        _exit(1);
    }
    fprintf(stdout, "Concurrent workers: %d\n", x);
    return 0;
}

int prog(const char *input, const char *c2c) {
    int res[2];
    if (kill(p, SIGUSR2) < 0) {
        perror("kill");
        _exit(1);
    }
    if (read(pipefd2[0], &res, sizeof(res)) != sizeof(res)) {
        perror("pipe_frontend");
        _exit(1);
    }
    fprintf(stdout, "Progress: %d%% - %d instances of the character '%c' found so far in %s\n", res[0], res[1], c2c[0], input);
    return 0;
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
    ssize_t rcnt;
    char buff[CHUNK];
    write(1, "> ", 2);
    rcnt = read(0, buff, sizeof(buff)-1);
    if (rcnt == 0) /* end-of-file */
        exit(0);
    if (rcnt < 0) { /* error */
        perror("read");
        exit(1);
    }
    char *arg = &buff[3];
    buff[rcnt] = '\0';
    if (strncmp(buff, "add", 3) == 0 || strncmp(buff, "del", 3) == 0) {
        while (*arg == ' ' || *arg == '\t') arg++;
        if (*arg == '\0' || *arg == '\n') {
            fprintf(stderr, "Please provide a number of workers\n");
            return;
        }
        char *endptr;
        int x = (int)strtol(arg, &endptr, 10);
        while (*endptr == ' ' || *endptr == '\t') *endptr++;
        if (*endptr != '\0' && *endptr != '\n') {
            fprintf(stderr, "Invalid number of workers\n");
            return;
        }
        if (x < 0) {
            fprintf(stderr, "Number must be non-negative\n");
            return;
        }
        if (buff[0] != 'a') x = -x;
        add(x);
    }
    else if (strncmp(buff, "exit", 4) == 0) {
        if (check(arg+1)) return;
        ext(); exit(0);
    } else if (strncmp(buff, "info", 4) == 0) {
        if (check(arg+1)) return;
        info();
    } else if (strncmp(buff, "prog", 4) == 0) {
        if (check(arg+1)) return;
        prog(input, c2c);
    } else if (strncmp(buff, "help", 4) == 0) {
        if (check(arg+1)) return;
        help();
    } else if (strncmp(buff, "ps", 2) == 0) {
        if (check(arg-1)) return;
        show_pstree(getpid());
    } else {
        check("a");
    }
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <input-file> <char>\n", argv[0]);
        return 1;
    }
    if ((pipe(pipefd1)) < 0) {
        perror("pipe_frontend");
        _exit(1);
    }
    if ((pipe(pipefd2)) < 0) {
        perror("pipe_frontend");
        _exit(1);
    }
    struct sigaction sa;
    sa.sa_handler = sighandler;
    sa.sa_flags = SA_RESTART;
    if (sigaction(SIGTERM, &sa, NULL) < 0) {
        perror("sigaction");
        _exit(1);
    }
    struct sigaction sa_pipe;
    sa_pipe.sa_handler = SIG_IGN;
    sa.sa_flags = SA_RESTART;
    if (sigaction(SIGPIPE, &sa_pipe, NULL) < 0) {
        perror("sigaction");
        _exit(1);
    }
    usleep(WAIT_T);
    p = fork();
    if (p < 0) {
        perror("fork");
        _exit(1);
    } else if (p == 0) {
        create_dispatcher(argv[1], argv[2]);
    }
    close(pipefd1[0]);
    close(pipefd2[1]);
    for (;;) {
        read_input(argv[1], argv[2]);
    }
    wait(NULL);
}
