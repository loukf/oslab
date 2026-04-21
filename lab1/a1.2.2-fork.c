#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wait.h>

char msg[1024];

void print_err(const char *s) {
    write(2, s, strlen(s));
}

int main(int argc, char *argv[]) {
    int x=67;
    pid_t p = fork();
    if (p < 0) {
        print_err("error: cannot fork process\n");
        _exit(1);
    } else if (p == 0) {
        sprintf(msg, "Hello from child PID=%d, Parent PID=%d.\n", getpid(), getppid());
        write(1, msg, strlen(msg));
        x = 42;
    } else {
        wait(NULL);
        sprintf(msg, "Child with PID=%d finished.\n", p);
        write(1, msg, strlen(msg));
    }
    sprintf(msg, "%d\n", x);
    write(1, msg, strlen(msg));
    return 0;
}
