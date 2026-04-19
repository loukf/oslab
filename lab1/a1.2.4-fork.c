#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char msg[1024];

void print_err(const char *s) {
    write(2, s, strlen(s));
}

int main(int argc, char *argv[]) {
    if (argc != 4) {
        sprintf(msg, "Usage: %s <input-file> <output-file> <char>\n", argv[0]);
        write(2, msg, strlen(msg));
        return 1;
    }
    pid_t p = fork();
    if (p < 0) {
        print_err("error: cannot fork process\n");
        _exit(1);
    } else if (p == 0) {
        sprintf(msg, "Hello from child PID=%d, Parent PID=%d.\n", getpid(), getppid());
        write(1, msg, strlen(msg));
        argv[0] = "a1.1-C";
        execv(argv[0], argv);
        print_err("error: execv failed\n");
        _exit(127);
    } else {
        wait(NULL);
        sprintf(msg, "Child with PID=%d finished.\n", p);
        write(1, msg, strlen(msg));
    }
    return 0;
}
