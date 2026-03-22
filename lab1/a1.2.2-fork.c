#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <input-file> <output-file> <char>\n", argv[0]);
        return 1;
    }
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
