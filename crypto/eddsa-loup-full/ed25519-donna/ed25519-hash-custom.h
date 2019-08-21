#ifdef ED25519_SHA512
    #include "../sha512.h"
    typedef crypto_sha512_ctx ed25519_hash_context;
#else
    #include "../monocypher.h"
    typedef crypto_blake2b_ctx ed25519_hash_context;
#endif

void ed25519_hash_init(ed25519_hash_context *ctx)
{
#ifdef ED25519_SHA512
    crypto_sha512_init(ctx);
#else
    crypto_blake2b_init(ctx);
#endif
}

void ed25519_hash_update(ed25519_hash_context *ctx, const uint8_t *in,
                         size_t inlen)
{
#ifdef ED25519_SHA512
    crypto_sha512_update(ctx, in, inlen);
#else
    crypto_blake2b_update(ctx, in, inlen);
#endif
}

void ed25519_hash_final(ed25519_hash_context *ctx, uint8_t *hash)
{
#ifdef ED25519_SHA512
    crypto_sha512_final(ctx, hash);
#else
    crypto_blake2b_final(ctx, hash);
#endif
}

void ed25519_hash(uint8_t *hash, const uint8_t *in, size_t inlen)
{
#ifdef ED25519_SHA512
    crypto_sha512(hash, in, inlen);
#else
    crypto_blake2b(hash, in, inlen);
#endif
}
