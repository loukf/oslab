#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <semaphore.h>

#define WAIT_T 500 * 1000

char msg[1024];
pid_t parent_pid;

sem_t *line_sems;
int *count;

void sighandler(int signum) {
    (void)signum;
    if (getpid() != parent_pid) return;
    fprintf(stdout, "\nSIGINT: %d instance%s found so far\n", *count, (*count == 1 ? "" : "s"));
    write(1, msg, strlen(msg));
}

void *create_shared_memory_area(unsigned int numbytes) {
	int pages;
	void *addr;

	if (numbytes == 0) {
		fprintf(stderr, "%s: internal error: called for numbytes == 0\n", __func__);
		exit(1);
	}

	/*
	 * Determine the number of pages needed, round up the requested number of
	 * pages
	 */
	pages = (numbytes - 1) / sysconf(_SC_PAGE_SIZE) + 1;

	/* Create a shared, anonymous mapping for this number of pages */
	/* TODO:  
	*/
    addr = mmap(NULL, pages, PROT_WRITE | PROT_READ, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
	return addr;
}

void destroy_shared_memory_area(void *addr, unsigned int numbytes) {
	int pages;

	if (numbytes == 0) {
		fprintf(stderr, "%s: internal error: called for numbytes == 0\n", __func__);
		exit(1);
	}

	/*
	 * Determine the number of pages needed, round up the requested number of
	 * pages
	 */
	pages = (numbytes - 1) / sysconf(_SC_PAGE_SIZE) + 1;

	if (munmap(addr, pages * sysconf(_SC_PAGE_SIZE)) == -1) {
		perror("destroy_shared_memory_area: munmap failed");
		exit(1);
	}
}

int main(int argc, char *argv[]) {
    if (argc != 4) {
        snprintf(msg, sizeof(msg), "Usage: %s <input-file> <output-file> <char>\n", argv[0]);
        write(2, msg, strlen(msg));
        return 1;
    }
    sigset_t sigset;
    sigemptyset(&sigset);
    struct sigaction sa;
    sa.sa_handler = sighandler;
    sa.sa_flags = SA_RESTART;
    sa.sa_mask = sigset;
    if (sigaction(SIGINT, &sa, NULL) < 0) {
        snprintf(msg, sizeof(msg), "error: sigaction failed\n");
        write(2, msg, strlen(msg));
        _exit(1);
    }
    parent_pid = getpid();
    int P = 13;
    int fdr, fdw;
    char c2c = argv[3][0];
    fdr = open(argv[1], O_RDONLY);
    if (fdr < 0) {
        snprintf(msg, sizeof(msg), "error: cannot open file to read\n");
        write(2, msg, strlen(msg));
        _exit(1);
    }
    unsigned int sems_size = sizeof(sem_t) * P;
    line_sems = create_shared_memory_area(sems_size);
    for (int i = 0; i < P; ++i) {
        sem_init(&line_sems[i], 1, (i == 0 ? 1 : 0));
    }
    count = create_shared_memory_area(sizeof(int));
    struct stat st;
    if (fstat(fdr, &st) < 0) {
        snprintf(msg, sizeof(msg), "error: fstat failed\n");
        write(2, msg, strlen(msg));
        exit(1);
    }
    off_t end = st.st_size;
    off_t chunk_size = (end-1)/P+1;
    for (int i = 0; i < P; ++i) {
        int child_count = 0;
        pid_t p = fork();
        usleep(WAIT_T);
        if (p < 0) {
            snprintf(msg, sizeof(msg), "error: cannot fork process\n");
            write(2, msg, strlen(msg));
            _exit(1);
        } else if (p == 0) {
            char buff[chunk_size+1];
            ssize_t rcnt;
            rcnt = pread(fdr, buff, sizeof(buff)-1, chunk_size*i);
            if (rcnt == 0) /* end‐of‐file */
                break;
            if (rcnt < 0) { /* error */
                snprintf(msg, sizeof(msg), "error: cannot read from input file\n");
                write(2, msg, strlen(msg));
                _exit(1);
            }
            for (int i = 0; i < rcnt; ++i) {
                if (buff[i] == c2c) {
                    child_count++;
                }
            }
            buff[rcnt] = '\0';
            sem_wait(&line_sems[i]);
            *count += child_count;
            if (i + 1 < P) {
                sem_post(&line_sems[i + 1]);
            }
            _exit(0);
        }
    }
    close(fdr);
    for (int i = 0; i < P; ++i) {
        wait(NULL);
    }
    int res = *count;
    destroy_shared_memory_area(count, sizeof(int));
    destroy_shared_memory_area(line_sems, sems_size);
    fdw = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, 0644);
    if (fdw < 0) {
        snprintf(msg, sizeof(msg), "error: cannot write to pipe\n");
        write(2, msg, strlen(msg));
        _exit(1);
    }
    snprintf(msg, sizeof(msg), "The character '%c' appears %d times in file %s.\n", c2c, res, argv[1]);
    write(fdw, msg, strlen(msg));
    close(fdw);
    return 0;
}
