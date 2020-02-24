// implementation for https://github.com/Kleshni/Elligator-2

#include <stdio.h>
#include <elligator-2-curve25519.h>

int main(void) {
	// 2fe57da347cd62431528daac5fbb290730fff684afc4cfc2ed90995f58cb3b74
	unsigned char bytes[32] = {47, 229, 125, 163, 71, 205, 98, 67, 21, 40, 218, 172, 95, 187, 41, 7, 48, 255, 246, 132, 175, 196, 207, 194, 237, 144, 153, 95, 88, 203, 59, 116};
	unsigned char out[32] = {77};
	bool r, flag;

	Elligator_2_Curve25519_initialize();
	r = Elligator_2_Curve25519_encode(out, bytes, flag);
	printf("r: %d, flag: %d\n", r, flag);
	for (int i = 0; i < 32; i++ ) {
		printf("%x", out[i]);
	}
	printf("\n");
	return 0;
}
