#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

void sighandler(int signum) {
    printf("\nSIGINT: Still alive...\n");
}

int main(int argc, char *argv[]) {
    struct sigaction sa;
    sa.sa_handler = sighandler;
    if (sigaction(SIGINT, &sa, NULL) < 0) {
        perror("sigaction");
        exit(1);
    }

    printf("%d\n", getpid());
    while (1) {
        sleep(1);
    }
}
