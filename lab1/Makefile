CC = gcc
CFLAGS = -std=gnu17 -Wall -O2

TARGETS := a1.1-C a1.1-system_calls a1.2.1-fork a1.2.2-fork a1.2.3-fork a1.2.4-fork a1.3-comm a1.4-frontend a1.4-dispatcher a1.4-worker

all: $(TARGETS)

$(TARGETS): %: %.o utils.o
	$(CC) $(CFLAGS) $^ -o $@

%.o: %.c utils.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f *.o $(TARGETS)
