#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define CHUNK 1024

char msg[CHUNK];

void print_err(const char *s) {
    write(2, s, strlen(s));
}

int main(int argc, char *argv[]) {
    if (argc != 4) {
        sprintf(msg, "Usage: %s <input-file> <output-file> <char>\n", argv[0]);
        write(2, msg, strlen(msg));
        return 1;
    }
    int fdr, fdw;
    char c2c = argv[3][0];
    fdr = open(argv[1], O_RDONLY);
    if (fdr < 0) {
        print_err("error: cannot open file to read\n");
        _exit(1);
    }
    int count = 0;
    char buff[CHUNK];
    ssize_t rcnt;
    for (;;) {
        rcnt = read(fdr, buff, sizeof(buff)-1);
        if (rcnt == 0) /* end-of-file */
            break;
        if (rcnt < 0) { /* error */
            print_err("error: problem reading from input file\n");
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
        print_err("error: problem opening file to write\n");
        _exit(1);
    }
    sprintf(msg, "The character '%c' appears %d times in file %s.\n", c2c, count, argv[1]);
    write(fdw, msg, strlen(msg));
    close(fdw);
    return 0;
}
