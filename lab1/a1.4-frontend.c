#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

pid_t p;
int pipefd1[2];
int pipefd2[2];

void show_pstree(pid_t p) {
    int ret;
    char cmd[1024];
    snprintf(cmd, sizeof(cmd), "echo; echo; pstree -a -G -c -p %ld; echo; echo",
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
    printf("Available commands:\n"
           "   add <x>\tadd x workers (search processes)\n"
           "   sub <x>\tremove x workers\n"
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
        perror("pipe");
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
        perror("pipe");
        _exit(1);
    }
    printf("Concurrent workers: %d\n", x);
    return 0;
}

int prog(const char c2c, const char *input) {
    int res[2];
    if (kill(p, SIGUSR2) < 0) {
        perror("kill");
        return -1;
    }
    if (read(pipefd2[0], &res, 2 * sizeof(int)) != 2 * sizeof(int)) {
        perror("pipe");
        _exit(1);
    }
    printf("Progress: %d%% - %d instances of the character '%c' found so far in %s\n", res[0], res[1], c2c, input);
    return 0;
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <input-file> <char>\n", argv[0]);
        return 1;
    }
    if ((pipe(pipefd1)) < 0) {
        perror("pipe");
        _exit(1);
    }
    if ((pipe(pipefd2)) < 0) {
        perror("pipe");
        _exit(1);
    }
    p = fork();
    if (p < 0) {
        perror("fork");
        _exit(1);
    } else if (p == 0) {
        close(pipefd1[1]);
        close(pipefd2[0]);
        char fd_str[2][16];
        sprintf(fd_str[0], "%d", pipefd1[0]);
        sprintf(fd_str[1], "%d", pipefd2[1]);
        char *new_argv[6] = {"a1.4-dispatcher", argv[1], argv[2], fd_str[0], fd_str[1], NULL};
        execv(new_argv[0], new_argv);
        perror("execv");
        _exit(127);
    }
    close(pipefd1[0]);
    close(pipefd2[1]);
    ssize_t rcnt;
    char buff[1024];
    for (;;) {
        write(1,"> ", 2);
        rcnt = read(0, buff, sizeof(buff)-1);
        if (rcnt == 0) /* end-of-file */
            break;
        if (rcnt < 0) { /* error */
            perror("read");
            exit(1);
        }
        char *arg = &buff[4];
        buff[rcnt] = '\0';
        if (strncmp(buff, "add", 3) == 0 || strncmp(buff, "sub", 3) == 0) {
            while (*arg == ' ' || *arg == '\t') arg++;
            if (*arg == '\0' || *arg == '\n') {
                fprintf(stderr, "Please provide a number of workers\n");
                continue;
            }
            char *endptr;
            int x = (int)strtol(arg, &endptr, 10);
            while (*endptr == ' ' || *endptr == '\t') *endptr++;
            if (*endptr != '\0' && *endptr != '\n') {
                fprintf(stderr, "Invalid number of workers\n");
                continue;
            }
            if (x < 0) {
                fprintf(stderr, "Number must be non-negative\n");
                continue;
            }
            if (buff[0] != 'a') x = -x;
            add(x);
        }
        else if (strncmp(buff, "exit", 4) == 0 && !check(arg)) {
                ext(); break;
        } else if (strncmp(buff, "info", 4) == 0 && !check(arg)) {
                info();
        } else if (strncmp(buff, "prog", 4) == 0 && !check(arg)) {
                prog(argv[2][0], argv[1]);
        } else if (strncmp(buff, "help", 4) == 0 && !check(arg)) {
                help();
        } else if (strncmp(buff, "ps", 2) == 0 && !check(arg-2)) {
                show_pstree(getpid());
        } else {
            check("a");
        }
    }
    wait(NULL);
}
