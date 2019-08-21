#include "monocypher.h"
#include "tweetnacl.h"
#include <stdio.h>
#include <string.h>

#define FOR(i, start, end)   for (size_t (i) = (start); (i) < (end); (i)++)

int main()
{
    uint8_t key[32]; memset(key, 0, 32);
    uint8_t sig[64]; memset(sig, 0, 64); // detatched signature
    uint8_t msg[65];                     // detatched message (as big as sm)
    uint8_t sm [65]; memset(sm , 0, 65); // signed message

for (unsigned a = 0; a < 32; a++) {
    printf("%d\n", a);
	for (unsigned j = 0; j < 256; j++) {
	    key[a] = j;
	    for (unsigned i = 0; i < 256; i++) {
	        unsigned long long size; // dummy size
	        int mono;
	        int tweet;
	        msg  [0] = i;
	        sm  [64] = i;
	        mono     = crypto_check(sig, key, msg, 1);
	        tweet    = crypto_sign_open(msg, &size, sm, 65ull, key);
	        if      (mono == -1 && tweet ==  0) { printf("."); }
 	        else if (mono ==  0 && tweet == -1) { printf("!"); }
	
	    }
	}
}

    printf("done.\n");

/*
    printf("\n");
    printf("- 0 : both Mono and Tweet accept the signature\n");
    printf("- 1 : both Mono and Tweet reject the signature\n");
    printf("- . : Mono accepts the signature, Tweet rejects it\n");
    printf("- ! : Mono rejects the signature, Tweet accepts it\n\n");
    printf("We try every one byte messages, from 0 to 255.\n");
    printf("If you see '!' anywhere, something's wrong.\n\n");

    for (unsigned l = 0; l < 16; l++) {
        for (unsigned c = 0; c < 16; c++) {
            unsigned i = (8 * l) + c;
            if      (mono[i] ==  0 && tweet[i] ==  0) { printf("0"); }
            else if (mono[i] == -1 && tweet[i] == -1) { printf("1"); }
            else if (mono[i] == -1 && tweet[i] ==  0) { printf("."); }
            else if (mono[i] ==  0 && tweet[i] == -1) { printf("!"); }
            else                                      { printf("?"); }
        }
        printf("\n");
    }
*/

    return 0;
}
