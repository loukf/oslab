#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <input-file> <output-file> <char>\n", argv[0]);
        return 1;
    }
    int fd;
    fd = open(argv[1], O_RDONLY);
    if (fd < 0) {
        perror("open");
        exit(1);
    }
    int count = 0;
    char c2c = argv[3][0];
    char buff[1024];
    ssize_t rcnt;
    for (;;) {
        rcnt = read(fd,buff, sizeof(buff)-1);
        if (rcnt == 0) /* end‐of‐file */
            break;
        if (rcnt < 0){ /* error */
            perror("read");
            exit(1);
        }
        for (int i = 0; i < rcnt; i++) {
            if (buff[i] == c2c) {
                count++;
            }
        }
    }
    close(fd);
    char msg[128];
    sprintf(msg, "The character '%c' appears %d times in file %s.\n", c2c, count, argv[1]);
    int fdw;
    fdw = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, S_IRUSR | S_IWUSR);
    if (fdw < 0) {
        perror("open");
        exit(1);
    }
    write(fdw,msg,strlen(msg));
    close(fdw);
    return 0;
}
