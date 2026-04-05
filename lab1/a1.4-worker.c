#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include "config.h"

int pipefd1[2];
int pipefd2[2];

void work(const int fdr, const char c2c) {
    int at[2] = {0, 0};
    ssize_t n = read(pipefd1[0], &at, sizeof(at));
    if (n < 0) {
        perror("pipe_worker0");
        exit(1);
    } else if (n == 0 || errno == EPIPE) {
        exit(0);
    }
    int offset = at[0]*at[1];
    int end = at[1];
    char buff[end+1];
    ssize_t rcnt;
    // printf("worker starting at chunk[%d]\n", at[0]);
    rcnt = pread(fdr, buff, sizeof(buff)-1, offset);
    if (rcnt == 0) { /* end of file */
        return;
    }
    if (rcnt < 0) { /* error */
        perror("pipe_worker1");
        exit(1);
    }
    buff[rcnt] = '\0';
    int res[2] = { at[0], 0 };
    for (int i = 0; i < rcnt; ++i) {
        if (buff[i] == c2c) {
            res[1]++;
        }
    }
    usleep(WORK_WAIT);
    ssize_t l = write(pipefd2[1], &res, sizeof(res));
    if (l == 0 || errno == EPIPE) {
        printf("exiting...\n");
        exit(0);
    } else if (l < 0) {
        perror("pipe_worker2");
        exit(1);
    }
    // printf("worker with pid %d read %d occurences at chunk[%d]\n", getpid(), res[1], res[0]);
}

int main(int argc, char *argv[]) {
    if (argc != 5) {
        fprintf(stderr, "error: Bad worker initialization\n");
        return 1;
    }
    char *endptr;
    int fdr = (int)strtol(argv[1], &endptr, 10);
    if (*endptr != '\0') {
        fprintf(stderr, "error: Invalid input FD: %s\n", argv[1]);
        return 1;
    }
    pipefd1[0] = (int)strtol(argv[3], &endptr, 10);
    if (*endptr != '\0') {
        fprintf(stderr, "error: Invalid pipe FD: %s\n", argv[3]);
        return 1;
    }
    pipefd2[1] = (int)strtol(argv[4], &endptr, 10);
    if (*endptr != '\0') {
        fprintf(stderr, "error: Invalid pipe FD: %s\n", argv[4]);
        return 1;
    }
    for (;;) {
        work(fdr, argv[2][0]);
        usleep(LOOP_WAIT);
    }
}
