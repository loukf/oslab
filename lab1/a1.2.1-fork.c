#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char msg[1024];

int main(int argc, char *argv[]) {
    pid_t p = fork();
    if (p < 0) {
        char err[] = "Error: cannot fork process\n";
        write(2, err, strlen(err));
        _exit(1);
    } else if (p == 0) {
        sprintf(msg, "Child PID=%d, Parent PID=%d.\n", getpid(), getppid());
        write(1, msg, strlen(msg));
    } else {
        wait(NULL);
        sprintf(msg, "Child with PID=%d finished.\n", p);
        write(1, msg, strlen(msg));
    }
    return 0;
}
