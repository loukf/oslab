#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>

long P = 0;

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
    if (argc == 4 || argc == 5) {
        argv[4] = "0";
        argv[5] = "0";
    } else if (argc == 5) {
        argv[5] = "0";
    } else if (argc != 6) {
        fprintf(stderr, "Usage: %s <input-file> <output-file> "
                "<char> <num_children> <sleep_seconds>\n", argv[0]);
        return 1;
    }
    struct sigaction sa1;
    struct sigaction sa2;
    sa1.sa_handler = sigahandler;
    if (sigaction(SIGUSR1, &sa1, NULL) < 0) {
        perror("sigaction");
        exit(1);
    }
    sa2.sa_handler = sigxhandler;
    if (sigaction(SIGUSR2, &sa2, NULL) < 0) {
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
    printf("Number of children: %d.\nSleep time: %ds.\n", P, y);
    /*
     * CALL DISPATCHER
     */
    while (1) {
        sleep(1);
    }
    // sleep(y);
}
