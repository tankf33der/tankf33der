#ifndef ROMU_H
#define ROMU_H
#include <stdint.h>
#include <stddef.h>
typedef struct prng_state {
  uint64_t state[4];
} prng_state;

#define ROTL(a,n) (((a) << (n)) | ((a) >> (64 - (n))))

// buf's size must be a multiple of 8 bytes.
static inline void prng_gen(prng_state *s, uint8_t buf[], size_t size) {
  size_t n = size / 8;
  uint64_t *b = (uint64_t *)buf;
  for (size_t i = 0; i < n; i++) {
    // ROMU: http://www.romu-random.org/romupaper.pdf
    uint64_t wp = s->state[0], xp = s->state[1], yp = s->state[2], zp = s->state[3];
    s->state[0] = 15241094284759029579u * zp;
    s->state[1] = zp + ROTL(wp, 52);
    s->state[2] = yp - xp;
    s->state[3] = yp + wp;
    s->state[3] = ROTL(zp, 19);
    b[i] = xp;
  }
}

prng_state prng_init(SEEDTYPE seed[4]) {
  prng_state s;
  // non zero
  for (size_t i = 0; i < 4; i++) { s.state[i] = i; }
  //if (s.state[2] == 0) { s.state[2] = 1; }
  return s;
}
#endif
