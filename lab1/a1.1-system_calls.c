#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "utils.h"

char msg[1024];

int main(int argc, char *argv[]) {
    if (argc != 4) {
        snprintf(msg, sizeof(msg), "Usage: %s <input-file> <output-file> <char>\n", argv[0]);
        safe_write(2, msg, strlen(msg));
        return 1;
    }
    int fdr, fdw;
    char c2c = argv[3][0];
    fdr = open(argv[1], O_RDONLY);
    if (fdr < 0) {
        snprintf(msg, sizeof(msg), "error: cannot open file to read\n");
        safe_write(2, msg, strlen(msg));
        _exit(1);
    }
    int count = 0;
    char buff[1024];
    ssize_t rcnt;
    for (;;) {
        rcnt = safe_read(fdr, buff, sizeof(buff)-1);
        if (rcnt == 0) /* end-of-file */
            break;
        if (rcnt < 0) { /* error */
            snprintf(msg, sizeof(msg), "error: cannot read from input file\n");
            safe_write(2, msg, strlen(msg));
            _exit(1);
        }
        buff[rcnt] = '\0';
        for (int i = 0; i < rcnt; ++i) {
            if (buff[i] == c2c) {
                count++;
            }
        }
    }
    close(fdr);
    fdw = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, 0644);
    if (fdw < 0) {
        snprintf(msg, sizeof(msg), "error: cannot open file to write\n");
        safe_write(2, msg, strlen(msg));
        _exit(1);
    }
    snprintf(msg, sizeof(msg), "The character '%c' appears %d times in file %s.\n", c2c, count, argv[1]);
    safe_write(fdw, msg, strlen(msg));
    close(fdw);
    return 0;
}
