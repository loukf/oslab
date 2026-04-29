#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "utils.h"

char msg[1024];

int main(int argc, char *argv[]) {
    pid_t p = fork();
    if (p < 0) {
        snprintf(msg, sizeof(msg), "error: cannot fork process\n");
        safe_write(2, msg, strlen(msg));
        _exit(1);
    } else if (p == 0) {
        snprintf(msg, sizeof(msg), "Hello from child PID=%d, Parent PID=%d.\n", getpid(), getppid());
        safe_write(1, msg, strlen(msg));
    } else {
        wait(NULL);
        snprintf(msg, sizeof(msg), "Child with PID=%d finished.\n", p);
        safe_write(1, msg, strlen(msg));
    }
    return 0;
}
