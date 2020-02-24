// code
// https://github.com/signalapp/libsignal-protocol-c/blob/master/src/curve25519/ed25519/additions/elligator.c

// testing
// https://github.com/signalapp/libsignal-protocol-c/blob/master/src/curve25519/ed25519/tests/internal_fast_tests.c
#include <stdio.h>

#define fe_frombytes crypto_sign_ed25519_ref10_fe_frombytes
#define fe_0 crypto_sign_ed25519_ref10_fe_0
#define fe_tobytes crypto_sign_ed25519_ref10_fe_tobytes
typedef int crypto_int32;
typedef crypto_int32 fe[10];
void fe_frombytes(fe h,const unsigned char *s);
void fe_0(fe);
void fe_tobytes(unsigned char *,const fe);
void elligator(fe u, const fe r);

int main(void) {
   // 2fe57da347cd62431528daac5fbb290730fff684afc4cfc2ed90995f58cb3b74
   unsigned char bytes[32] = {47, 229, 125, 163, 71, 205, 98, 67, 21, 40, 218, 172, 95, 187, 41, 7, 48, 255, 246, 132, 175, 196, 207, 194, 237, 144, 153, 95, 88, 203, 59, 116};
   fe in, out;

   fe_0(in);
   fe_0(out);
   fe_frombytes(in, bytes);
   elligator(out, in);
   fe_tobytes(bytes, out);
   for (int i = 0; i < 32; i++) {
      printf("%x", bytes[i]);
   }
   printf("\n");

   return 0;
}
