#include <unistd.h>
#include <errno.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "config.h"

pid_t p;
int pipefd1[2];
int pipefd2[2];

void sigchldhandler(int signum) {
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
        fprintf(stdout, "\n");
        _exit(WTERMSIG(status));
    } else if (WIFEXITED(status)) {
        _exit(WEXITSTATUS(status));
    }
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

int check(const char *s) {
    while (*s == ' ' || *s == '\t') s++;
    if (*s == '\n' || *s == '\0') {
        return 1;
    }
    fprintf(stderr, "Unknown command. Type 'help' to see the available commands\n");
    return 0;
}

int check_with_arg(const char *s, int *x_out) {
    if (*s != '\0' && *s != '\n' && *s != '\t' && *s != ' ') {
        check("a");
        return 0;
    }
    while (*s == ' ' || *s == '\t') s++;
    if (*s == '\0' || *s == '\n') {
        fprintf(stderr, "Please provide a number of workers\n");
        return 0;
    }
    char *endptr;
    int x = (int)strtol(s, &endptr, 10);
    if (endptr == s) {
        fprintf(stderr, "Invalid number of workers\n");
        return 0;
    }
    while (*endptr == ' ' || *endptr == '\t') endptr++;
    if (*endptr != '\0' && *endptr != '\n') {
        fprintf(stderr, "Invalid number of workers\n");
        return 0;
    }
    if (x < 0) {
        fprintf(stderr, "Number must be non-negative\n");
        return 0;
    }
    *x_out = x;
    return 1;
}

void help() {
    fprintf(stdout,
            "Available commands:\n"
            "   add <x>\tadd x workers (search processes)\n"
            "   del <x>\tremove x workers\n"
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
    _exit(0);
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
        exit(-1);
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
    double percent = ((double)res[0] / (double)CHUNK_NUM) * 100.0;
    fprintf(stdout, "Progress: %.2f%% - %d instances of the character '%c' found so far in %s\n", percent, res[1], c2c[0], input);
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
    if (rcnt == 0) { /* end-of-file */
        exit(0);
    }
    if (rcnt < 0) { /* error */
        perror("read");
        exit(1);
    }
    if (buff[0] == '\n') { /* empty-line */
        return; 
    }
    buff[rcnt] = '\0';
    char *s = &buff[0];
    while (*s == ' ' || *s == '\t') s++;
    int x;
    if (strncmp(s, "add", 3) == 0) {
        if (check_with_arg(&s[3], &x)) {
            add(x);
        }
    } else if (strncmp(s, "sub", 3) == 0) {
        if (check_with_arg(&s[3], &x)) {
            add(-x);
        }
    } else if (strncmp(s, "exit", 4) == 0) {
        if (check(&buff[4])) {
            ext();
        }
    } else if (strncmp(s, "info", 4) == 0) {
        if (check(&s[4])) {
            info();
        }
    } else if (strncmp(s, "prog", 4) == 0) {
        if (check(&s[4])) {
            prog(input, c2c);
        }
    } else if (strncmp(s, "help", 4) == 0) {
        if (check(&s[4])) {
            help();
        }
    } else if (strncmp(s, "ps", 2) == 0) {
        if (check(&s[2])) {
            show_pstree(getpid());
        }
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
    sa.sa_handler = sigchldhandler;
    sa.sa_flags = SA_RESTART;
    if (sigaction(SIGCHLD, &sa, NULL) < 0) {
        perror("sigaction");
        _exit(1);
    }
    struct sigaction sa_pipe;
    sa_pipe.sa_handler = SIG_IGN;
    sa_pipe.sa_flags = SA_RESTART;
    if (sigaction(SIGPIPE, &sa_pipe, NULL) < 0) {
        perror("sigaction");
        _exit(1);
    }
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
        usleep(WAIT_T);
    }
}
