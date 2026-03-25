#include <unistd.h>
#include <sys/types.h>
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
        print_err("Error: cannot fork process\n");
        _exit(1);
    } else if (p == 0) {
        argv[0] = "a1.1-C";
        execv(argv[0], argv);
        print_err("Error: execv failed\n");
        _exit(127);
    } else {
        wait(NULL);
    }
    return 0;
}
