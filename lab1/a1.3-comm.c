#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <input-file> <output-file> <char>\n", argv[0]);
        return 1;
    }
    int P = 7;
    int fd, fdw;
    char c2c = argv[3][0];
    fd = open(argv[1], O_RDONLY);
    if (fd < 0) {
        perror("open");
        exit(1);
    }
    int pfd[P][2];
    for (int i = 0; i < P; ++i) {
        if ((pipe(pfd[i])) < 0) {
            perror("pipe");
            exit(1);
        }
    }
    size_t s = lseek(fd, 0, SEEK_END);
    size_t size_read = s/P+1;
    int res = 0;
    pid_t p;
    for (int i = 0; i < P; ++i) {
        p = fork();
        // if (kill(p, SIGUSR1) < 0) {
        //     perror("kill");
        //     exit(1);
        // }

        if (p < 0) {
            perror("fork");
            exit(1);
        } else if (p == 0) {
            // printf("Child %d with PID %d: ", i, getpid());
            int count = 0;
            char buff[size_read];
            ssize_t rcnt;
            rcnt = pread(fd,buff, sizeof(buff)-1, (size_read-1)*i);
            if (rcnt == 0) /* end‐of‐file */
                break;
            if (rcnt < 0) { /* error */
                perror("read");
                exit(1);
            }
            buff[rcnt] = '\0';
            for (int i = 0; i < rcnt; i++) {
                if (buff[i] == c2c) {
                    count++;
                }
            }
            // printf("%s\t(%d)\n", buff, count);
            write(pfd[i][1], &count, sizeof(int));
            return 0;
        }
    }
    wait(NULL);
    int child_count;
    for (int i = 0; i < P; ++i) {
        read(pfd[i][0], &child_count, sizeof(int));
        res += child_count;
    }
    size_t size = 1024;
    char msg[size];
    int len = snprintf(msg, size, "The character '%c' appears %d times in file %s.\n",
            c2c, res, argv[1]);
    if (len >= size) {
        fprintf(stderr, "Message too long\n");
        return 1;
    }
    fdw = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, S_IRUSR | S_IWUSR);
    if (fdw < 0) {
        perror("open");
        exit(1);
    }
    write(fdw, msg, len);
    close(fd);
    close(fdw);
}
