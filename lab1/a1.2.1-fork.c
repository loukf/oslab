#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>

int main(int argc, char *argv[]) {
    pid_t p = fork();
    if (p < 0) {
        perror("fork");
        exit(1);
    } else if (p == 0) {
        printf("%d\n", getppid());
    } else {
        wait(NULL);
        printf("%d\n", getpid());
    }
}
