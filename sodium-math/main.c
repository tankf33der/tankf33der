#include <stdlib.h>
#include <string.h>
#include "sodium.h"

int main(void) {
	unsigned char nonce8[4];
	unsigned char n[4];
	unsigned char nonce17[5100];
	memset(nonce8, 21, sizeof nonce8);
	memset(n, 5, sizeof n);
	//sodium_increment(nonce8, sizeof nonce8);
	sodium_sub(nonce8, n, sizeof nonce8);
	printf("%s\n", sodium_bin2hex(nonce17, sizeof nonce17, nonce8, sizeof nonce8));
/*
	for(int i = 0U; i < 6; i++) {
		printf("%d\n", i);
	}
*/
	unsigned char d = 0;
	for (; d < 255; d++ ) {
		unsigned char r;
		r = 1 & ((d - 1) >> 8);
		
			printf("%d\n", d);
		
	}

	unsigned char z = 0;
	z = (0 - 1) >> 8;
	printf("z: %d\n", z);
}
