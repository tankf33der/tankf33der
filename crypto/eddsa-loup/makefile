CC=gcc -std=c99
CFLAGS= -pedantic -Wall -Wextra -O3 -march=native

.PHONY: all clean

all: compare.out
	./compare.out

clean:
	rm -f *.o *.out

compare.out: main.o monocypher.o sha512.o tweetnacl.o
	$(CC) $(CFLAGS) $^ -o $@

main.o      : main.c       monocypher.h sha512.h tweetnacl.h
monocypher.o: monocypher.c monocypher.h sha512.h
sha512.o    : sha512.c                  sha512.h
tweetnacl.o : tweetnacl.c                        tweetnacl.h
main.o monocypher.o sha512.o tweetnacl.o:
	$(CC) $(CFLAGS) -c $< -o $@
