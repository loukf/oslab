#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char msg[1024];

void print_err(const char *s) {
    write(2, s, strlen(s));
}

int main(int argc, char *argv[]) {
    pid_t p = fork();
    int x;
    if (p < 0) {
        print_err("Error: cannot fork process\n");
        _exit(1);
    } else if (p == 0) {
        x = 69;
    } else {
        x = 67;
    }
    sprintf(msg, "%d\n", x);
    write(1, msg, strlen(msg));
    return 0;
}
