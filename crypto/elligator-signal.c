#define fe_frombytes crypto_sign_ed25519_ref10_fe_frombytes
void fe_frombytes(fe h,const unsigned char *s)

int main(void) {
   unsigned char bytes[32];
   fe in, out;

   for (i = 0; i < 32; i++) {
      bytes[i] = 0;
   }
   fe_0(in);
   printf("%lu\n", in[0]);

   return 0;
}
