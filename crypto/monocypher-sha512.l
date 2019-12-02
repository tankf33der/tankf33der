`(== 64 64)
(load "sha512.l")
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de mono_sha512 (M)
   (let (L (length M)  R)
      (native
         "libmonocypher.so"
         "crypto_sha512"
         NIL
         '(R (64 B . 64))
         (cons NIL (cons L) M)
         L )
      R ) )
(de mono_sha512_init (M)
   (native
      "libmonocypher.so"
      "crypto_sha512_init"
      NIL
      M ) )
(de mono_sha512_update (M D)
   (let Len (length D)
      (native
         "libmonocypher.so"
         "crypto_sha512_update"
         NIL
         M
         (cons NIL (cons Len) D)
         Len ) ) )
(de mono_sha512_fin (M)
   (let R NIL
      (native
         "libmonocypher.so"
         "crypto_sha512_final"
         NIL
         M
         '(R (64 B . 64)) )
      R ) )
(de sodium_sha512 (M)
   (let (L (length M)  R)
      (native
         "libsodium.so"
         "crypto_hash_sha512"
         'I
         '(R (64 B . 64))
         (cons NIL (cons L) M)
         L )
      R ) )
(de sodium_sha512_init (S)
   (native
      "libsodium.so"
      "crypto_hash_sha512_init"
      'I
      S ) )
(de sodium_sha512_update (S D)
   (let Len (length D)
      (native
         "libsodium.so"
         "crypto_hash_sha512_update"
         'I
         S
         (cons NIL (cons Len) D)
         Len ) ) )
(de sodium_sha512_fin (S)
   (let R NIL
      (native
         "libsodium.so"
         "crypto_hash_sha512_final"
         'I
         S
         '(R (64 B . 64)) )
      R ) )
(for N 1024
   (let D (randL N)
      (test (sha512 D) (sodium_sha512 D)) ) )
(for N 1024
   (let D (range 1 N)
      (test (mono_sha512 D) (sodium_sha512 D)) ) )
(setq M (native "@" "malloc" 'N 856))
(setq S (native "@" "malloc" 'N 208))
(do 1024
   (mono_sha512_init M)
   (sodium_sha512_init S)
   (do (rand 64 128)
      (let D (randL (rand 256 6666))
         (mono_sha512_update M D)
         (sodium_sha512_update S D) ) )
   (test
      (mono_sha512_fin M)
      (sodium_sha512_fin S) ) )
(for N 9999
   (let D (need N 255)
      (mono_sha512_init M)
      (sodium_sha512_init S)
      (mono_sha512_update M D)
      (sodium_sha512_update S D)
      (test
         (mono_sha512_fin M)
         (sodium_sha512_fin S) ) ) )
(for N 9999
   (let D (need N 0)
      (mono_sha512_init M)
      (sodium_sha512_init S)
      (mono_sha512_update M D)
      (sodium_sha512_update S D)
      (test
         (mono_sha512_fin M)
         (sodium_sha512_fin S) ) ) )
(for N 9999
   (let D (need N (rand 6666 9999))
      (mono_sha512_init M)
      (sodium_sha512_init S)
      (mono_sha512_update M D)
      (sodium_sha512_update S D)
      (test
         (mono_sha512_fin M)
         (sodium_sha512_fin S) ) ) )

(msg 'ok)
(bye)
   

