#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    int fd, fw;
    char c2c = argv[3][0];
    fd = open(argv[1], O_RDONLY);
    if (fd == -1) {
        perror("open");
        exit(1);
    }
    int pipefd[2];
    if ((pipe(pipefd)) == -1) {
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
            if (rcnt == -1){ /* error */
                perror("read");
                exit(1);
            }
            for (int i = 0; i < rcnt; i++) {
                if (buff[i] == c2c) {
                    count++;
                }
            }
        }
        write(pipefd[1], &count, sizeof(int));
    } else {
        wait(NULL);
        char msg[128];
        int child_count;
        read(pipefd[0], &child_count, sizeof(int));
        sprintf(msg, "The character '%c' appears %d times in file %s.\n", c2c, child_count, argv[1]);
        fw = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, S_IRUSR | S_IWUSR);
        if (fw == -1) {
            perror("open");
            exit(1);
        }
        write(fw,msg,strlen(msg));
        close(fw);
        close(fd);
    }
}
