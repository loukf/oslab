#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>

long P = 0;

void sighandler(int signum) {
    printf("\nSIGINT: Current workers: %d.\n", P);
}

void sigahandler(int signum) {
    printf("\nSIGUSR1: Add worker. Current workers: %d.\n", ++P);
}

void sigxhandler(int signum) {
    if (P == 0) {
        printf("\nSIGUSR2: Cannot remove any more workers. Current workers: %d.\n", P);
        return;
    }
    printf("\nSIGUSR2: Remove worker. Current workers: %d.\n", --P);
}

int main(int argc, char *argv[]) {
    if (argc != 6) {
        fprintf(stderr, "Usage: %s <input-file> <output-file> "
                "<char> <num_workers> <sleep_seconds>\n", argv[0]);
        return 1;
    }
    struct sigaction sa_status;
    sa_status.sa_handler = sighandler;
    if (sigaction(SIGINT, &sa_status, NULL) < 0) {
        perror("sigaction");
        exit(1);
    }
    struct sigaction sa_add;
    sa_add.sa_handler = sigahandler;
    if (sigaction(SIGUSR1, &sa_add, NULL) < 0) {
        perror("sigaction");
        exit(1);
    }
    struct sigaction sa_remove;
    sa_remove.sa_handler = sigxhandler;
    if (sigaction(SIGUSR2, &sa_remove, NULL) < 0) {
        perror("sigaction");
        exit(1);
    }
    printf("Current pid: %d.\n", getpid());
    char *endptr;
    P = strtol(argv[4], &endptr, 10);
    if (*endptr != '\0' || P < 0) {
        fprintf(stderr, "Invalid number of children: %s\n", argv[1]);
        return 1;
    }
    long y = strtol(argv[5], &endptr, 10);
    if (*endptr != '\0' || y < 0) {
        fprintf(stderr, "Invalid sleep time: %s\n", argv[2]);
        return 1;
    }
    printf("Number of initial workers: %d.\nSleep time: %ds.\n", P, y);
    /*
     * CALL DISPATCHER
     */
    while (1) {
        sleep(1);
    }
    // sleep(y);
}
