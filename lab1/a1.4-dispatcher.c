#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

void show_pstree(pid_t p) {
    int ret;
    char cmd[1024];
    snprintf(cmd, sizeof(cmd), "echo; echo; pstree -a -G -c -p %ld; echo; echo",
            (long)p);
    cmd[sizeof(cmd)-1] = '\0';
    ret = system(cmd);
    if (ret < 0) {
        perror("system");
        exit(104);
    }
}

void sighandler(int signum) {
    printf("\nSIGINT: Still alive...\n");
}

int main(int argc, char *argv[]) {
    struct sigaction sa;
    sa.sa_handler = sighandler;
    if (sigaction(SIGINT, &sa, NULL) < 0) {
        perror("sigaction");
        exit(1);
    }

    pid_t p = getpid();
    show_pstree(p);
    printf("%d\n", p);
    while (1) {
        sleep(1);
    }
}
