#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    pid_t p = fork();
    int x;
    if (p < 0) {
        perror("fork");
        exit(1);
    } else if (p == 0) {
        x = 69;
    } else {
        x = 67;
    }
    printf("%d\n", x);
}
