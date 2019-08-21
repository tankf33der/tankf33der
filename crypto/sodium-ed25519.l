`(== 64 64)
(de soda_init (C)
   (native
      "libsodium.so"
      "crypto_sign_init"
      NIL
      C ) )
(de soda_update (C M)
   (let ML (length M)
      (native
         "libsodium.so"
         "crypto_sign_update"
         NIL
         C
         (cons NIL (cons ML) M)
         ML ) ) )
(de soda_fin (C Prv)
   (let Sign NIL
      (native
         "libsodium.so"
         "crypto_sign_final_create"
         NIL
         C
         '(Sign (64 B . 64))
         0
         (cons NIL (64) Prv) )
      Sign ) )
(de soda_detached (D Size Prv)
   (let Sign NIL
      (native
         "libsodium.so"
         "crypto_sign_detached"
         NIL
         '(Sign (64 B . 64))
         0
         D
         Size
         (cons NIL (64) Prv) )
      Sign ) )
(de soda_seed_keypair (Seed)
   (let (SK NIL  PK NIL)
      (native
         "libsodium.so"
         "crypto_sign_seed_keypair"
         NIL
         '(PK (32 B . 32))
         '(SK (64 B . 64))
         (cons NIL (32) Seed) )
      (list PK SK) ) )
(de soda_start NIL
   (native "libsodium.so" "sodium_init") )
(de sodium_sha512_init (S)
   (native
      "libsodium.so"
      "crypto_hash_sha512_init"
      'I
      S ) )
(de sodium_sha512_update (S D Size)
   (native
      "libsodium.so"
      "crypto_hash_sha512_update"
      'I
      S
      D
      Size ) )
(de sodium_sha512_fin (S)
   (let R NIL
      (native
         "libsodium.so"
         "crypto_hash_sha512_final"
         'I
         S
         '(R (64 B . 64)) )
      R ) )
