#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <input-file> <output-file> <char>\n", argv[0]);
        return 1;
    }
    int fd, fdw;
    char c2c = argv[3][0];
    fd = open(argv[1], O_RDONLY);
    if (fd < 0) {
        perror("open");
        exit(1);
    }
    int pfd[2];
    if ((pipe(pfd)) < 0) {
        perror("pipe");
        exit(1);
    }
    pid_t p = fork();
    if (p < 0) {
        perror("fork");
        exit(1);
    } else if (p == 0) {
        int count = 0;
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
        write(pfd[1], &count, sizeof(int));
    } else {
        wait(NULL);
        int child_count;
        read(pfd[0], &child_count, sizeof(int));
        size_t size = 1024;
        char msg[size];
        int len = snprintf(msg, size, "The character '%c' appears %d times in file %s.\n",
                c2c, child_count, argv[1]);
        if (len >= size) {
            fprintf(stderr, "Message too long\n");
            return 1;
        }
        fdw = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, 0644);
        if (fdw < 0) {
            perror("open");
            exit(1);
        }
        write(fdw, msg, len);
        close(fd);
        close(fdw);
    }
}
