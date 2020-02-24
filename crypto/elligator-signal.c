#include <stdio.h>

#define fe_frombytes crypto_sign_ed25519_ref10_fe_frombytes
#define fe_0 crypto_sign_ed25519_ref10_fe_0
typedef int crypto_int32;
typedef crypto_int32 fe[10];
void fe_frombytes(fe h,const unsigned char *s);
void fe_0(fe);


int main(void) {
   unsigned char bytes[32];
   fe in, out;

   for (int i = 0; i < 32; i++) {
      bytes[i] = 0;
   }
   fe_0(in);
   printf("%lu\n", in[0]);

   return 0;
}
