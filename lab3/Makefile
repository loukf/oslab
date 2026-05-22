.PHONY: all clean

all: mmap mandel-fork a1.3-comm-new

CC = gcc
CFLAGS = -g -Wall -Wextra -O2 -lm
SHELL= /bin/bash

mmap: mmap.o help.o
	$(CC) $(CFLAGS) $^ -o $@

%.s: %.c
	$(CC) $(CFLAGS) -S -fverbose-asm $<

%.o: %.c
	$(CC) $(CFLAGS) -c $<

%.i: %.c
	gcc -Wall -E $< | indent -kr > $@

a1.3-comm-new: a1.3-comm-new.c
	$(CC) $(CFLAGS) -o a1.3-comm-new a1.3-comm-new.c $(LIBS)

mandel-fork: mandel-lib.o mandel-fork.o
	$(CC) $(CFLAGS) -o mandel-fork mandel-lib.o mandel-fork.o $(LIBS)

mandel-lib.o: mandel-lib.h mandel-lib.c
	$(CC) $(CFLAGS) -c -o mandel-lib.o mandel-lib.c $(LIBS)

mandel-fork.o: mandel-fork.c
	$(CC) $(CFLAGS) -c -o mandel-fork.o mandel-fork.c $(LIBS)

clean:
	rm -f *.s *.o mmap mandel-fork a1.3-comm-new
