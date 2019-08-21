#include "monocypher.h"
#include "ed25519-donna/ed25519.h"
#include "tweetnacl.h"
#include <stdio.h>
#include <string.h>

#define FOR(i, start, end)   for (size_t (i) = (start); (i) < (end); (i)++)

int main()
{
    uint8_t key[32]; memset(key, 0, 32); key[31] = 128;
    uint8_t sig[64]; memset(sig, 0, 64); // detatched signature
    uint8_t msg[65];                     // detatched message (as big as sm)
    uint8_t sm [65]; memset(sm , 0, 65); // signed message

    // Result buffers
    int mono [256];
    int donna[256];
    int tweet[256];

    printf("Trying every one byte messages, from {0} to {255}...\n");

    FOR (i, 0, 256) {
        unsigned long long size; // dummy size
        msg  [0] = i;
        sm  [64] = i;
        mono [i] = crypto_check(sig, key, msg, 1);
        donna[i] = ed25519_sign_open(msg, 1, key, sig);
        tweet[i] = crypto_sign_open(msg, &size, sm, 65ull, key);
    }

    printf("\n");
    printf("- a : Accepts the signature\n");
    printf("-   : Rejects the signature\n");
    printf("- ? : Return value is neither 0 nor -1\n");
    printf("\n");
    printf("+------------------+------------------+------------------+\n");
    printf("|    Monocypher    |  ed25519-Donna   |    TweetNaCl     |\n");
    printf("+------------------+------------------+------------------+\n");
    FOR (l, 0, 16) {
        printf("| ");
        FOR (c, 0, 16) {
            unsigned i = (8 * l) + c;
            if      (mono [i] ==  0 ) { printf("a"); }
            else if (mono [i] == -1 ) { printf(" "); }
            else                      { printf("?"); }
        }
        printf(" | ");
        FOR (c, 0, 16) {
            unsigned i = (8 * l) + c;
            if      (donna[i] ==  0 ) { printf("a"); }
            else if (donna[i] == -1 ) { printf(" "); }
            else                      { printf("?"); }
        }
        printf(" | ");
        FOR (c, 0, 16) {
            unsigned i = (8 * l) + c;
            if      (tweet[i] ==  0 ) { printf("a"); }
            else if (tweet[i] == -1 ) { printf(" "); }
            else                      { printf("?"); }
        }
        printf(" |\n");
    }
    printf("+------------------+------------------+------------------+\n");

    printf("\n");
    printf("-   : Mono and the other library aggree\n");
    printf("- . : Mono accepts the signature, other rejects it\n");
    printf("- ! : Mono rejects the signature, other accepts it\n");
    printf("\n");

    printf("+------------------+------------------+\n");
    printf("|  Mono vs donna   |  Mono vs Tweet   |\n");
    printf("+------------------+------------------+\n");
    FOR (l, 0, 16) {
        printf("| ");
        FOR (c, 0, 16) {
            unsigned i = (8 * l) + c;
            if      (mono[i] ==  tweet[i])             { printf(" "); }
            else if (mono[i] == -1 && tweet[i] ==  0 ) { printf("."); }
            else if (mono[i] ==  0 && tweet[i] == -1 ) { printf("!"); }
            else                                       { printf("?"); }
        }
        printf(" | ");
        FOR (c, 0, 16) {
            unsigned i = (8 * l) + c;
            if      (mono[i] ==  donna[i])             { printf(" "); }
            else if (mono[i] == -1 && donna[i] ==  0 ) { printf("."); }
            else if (mono[i] ==  0 && donna[i] == -1 ) { printf("!"); }
            else                                       { printf("?"); }
        }
        printf(" |\n");
    }
    printf("+------------------+------------------+\n");

    printf("\n");
    printf("Conclusion:\n");

    const char *mono_vs_donna = "identical";
    const char *mono_vs_tweet = "identical";
    FOR(i, 0, 256) {
        if (mono[i] != donna[i]) { mono_vs_donna = "different"; }
        if (mono[i] != tweet[i]) { mono_vs_tweet = "different"; }
    }

    printf("Monocypher and TweetNacl     give %s results\n", mono_vs_tweet);
    printf("Monocypher and ed25519-Donna give %s results\n", mono_vs_donna);
    return 0;
}
