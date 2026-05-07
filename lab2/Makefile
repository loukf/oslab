#
# Makefile
# 

CC = gcc

# CAUTION: Always use '-pthread' when compiling POSIX threads-based
# applications, instead of linking with "-lpthread" directly.
CFLAGS = -Wall -O2 -lm -pthread
LIBS = 

all: simplesync-mutex simplesync-atomic mandel-condition mandel-semaphore simplesync-mutex.s simplesync-atomic.s

simplesync-mutex.s: simplesync.c
	$(CC) $(CFLAGS) -DSYNC_MUTEX -g -S -o simplesync-mutex.s simplesync.c

simplesync-atomic.s: simplesync.c
	$(CC) $(CFLAGS) -DSYNC_ATOMIC -g -S -o simplesync-atomic.s simplesync.c
## Simple sync (two versions)
simplesync-mutex: simplesync-mutex.o
	$(CC) $(CFLAGS) -o simplesync-mutex simplesync-mutex.o $(LIBS)

simplesync-atomic: simplesync-atomic.o
	$(CC) $(CFLAGS) -o simplesync-atomic simplesync-atomic.o $(LIBS)

simplesync-mutex.o: simplesync.c
	$(CC) $(CFLAGS) -DSYNC_MUTEX -c -o simplesync-mutex.o simplesync.c

simplesync-atomic.o: simplesync.c
	$(CC) $(CFLAGS) -DSYNC_ATOMIC -c -o simplesync-atomic.o simplesync.c

## Mandel
mandel-condition: mandel-lib.o mandel-condition.o
	$(CC) $(CFLAGS) -o mandel-condition mandel-lib.o mandel.o $(LIBS)

mandel-semaphore: mandel-lib.o mandel-semaphore.o
	$(CC) $(CFLAGS) -o mandel-semaphore mandel-lib.o mandel.o $(LIBS)

mandel-lib.o: mandel-lib.h mandel-lib.c
	$(CC) $(CFLAGS) -c -o mandel-lib.o mandel-lib.c $(LIBS)

mandel-condition.o: mandel-condition.c
	$(CC) $(CFLAGS) -c -o mandel.o mandel-condition.c $(LIBS)

mandel-semaphore.o: mandel-semaphore.c
	$(CC) $(CFLAGS) -c -o mandel.o mandel-semaphore.c $(LIBS)

clean:
	rm -f *.s *.o simplesync-mutex simplesync-atomic mandel-condition mandel-semaphore simplesync-mutex.s simplesync-atomic.s
