CC=gcc -std=c99
USER_FLAGS=
CFLAGS= -pedantic -Wall -Wextra -O3 -march=native $(USER_FLAGS)

.PHONY: all clean

all: compare.out
	./compare.out

clean:
	rm -f *.o *.out

compare.out: main.o monocypher.o sha512.o ed25519.o tweetnacl.o
	$(CC) $(CFLAGS) $^ -o $@  $$(pkg-config --libs libsodium)


ed25519.o: ed25519-donna/ed25519.c \
           $(wildcard ed25519-donna/*.h) monocypher.h sha512.h
	$(CC) $(CFLAGS) -c $<                 \
            -I ../../src                      \
            -I ../../src/optional             \
            $$(pkg-config --cflags libsodium) \
            -DED25519_CUSTOMHASH              \
            -DED25519_TEST                    \
            -DED25519_NO_INLINE_ASM           \
            -DED25519_FORCE_32BIT

main.o      : main.c       monocypher.h sha512.h tweetnacl.h
monocypher.o: monocypher.c monocypher.h sha512.h
sha512.o    : sha512.c                  sha512.h
tweetnacl.o : tweetnacl.c                        tweetnacl.h
main.o monocypher.o sha512.o tweetnacl.o:
	$(CC) $(CFLAGS) -c $< -o $@
