#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include "config.h"

int pipefd1[2];
int pipefd2[2];

int main(int argc, char *argv[]) {
    if (argc != 5) {
        fprintf(stderr, "error: Bad worker initialization\n");
        return 1;
    }
    char *endptr;
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
    char c2c = argv[2][0];
    int fdr = open(argv[1], O_RDONLY);
    if (fdr < 0) {
        perror("read");
        _exit(1);
    }
    for (;;) {
        usleep(WAIT_T);
        int res[2] = {0, 0};
        ssize_t n = read(pipefd1[0], &res, sizeof(res));
        if (n < 0) {
            perror("pipe_worker");
            _exit(1);
        } else if (n == 0) _exit(0);
        int offset = res[0];
        int chunk = res[1];
        int count = 0;
        char buff[chunk+1];
        ssize_t rcnt;
        rcnt = pread(fdr, buff, sizeof(buff)-1, offset);
        if (rcnt == 0) /* end of file */
            break;
        if (rcnt < 0) { /* error */
            perror("pipe_worker");
            _exit(1);
        }
        for (int i = 0; i < rcnt; ++i) {
            if (buff[i] == c2c) {
                count++;
            }
        }
        buff[rcnt] = '\0';
        if (write(pipefd2[1], &count, sizeof(int)) != sizeof(int)) {
            perror("pipe_worker");
            _exit(1);
        }
    }
}
