`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de mono_init (M K)
   (native
      "libmonocypher.so"
      "crypto_poly1305_init"
      NIL
      M
      (cons NIL (32) K) ) )
(de mono_update (M D S)
      (native
         "libmonocypher.so"
         "crypto_poly1305_update"
         NIL
         M
         D
         S ) )
(de mono_fin (M)
   (let R NIL
      (native
         "libmonocypher.so"
         "crypto_poly1305_final"
         NIL
         M
         '(R (16 B . 16)) )
      R ) )
(de sodium_init (S K)
   (native
      "libsodium.so"
      "crypto_onetimeauth_poly1305_init"
      'I
      S
      (cons NIL (32) K) ) )
(de sodium_update (S D Size)
   (let Len (length L)
      (native
         "libsodium.so"
         "crypto_onetimeauth_poly1305_update"
         'I
         S
         D
         Size ) ) )
(de sodium_fin (S)
   (let R NIL
      (native
         "libsodium.so"
         "crypto_onetimeauth_poly1305_final"
         'I
         S
         '(R (16 B . 16)) )
      R ) )
(de mmap (L F)
   (native "@" "mmap" 'N 0 L 1 2 F 0) )
(de munmap (A L)
   (native "@" "munmap" 'N A L) )
(let 
   (F (car (argv))
      Size (car (info F))
      Map (mmap Size (open F T))
      MonoMem (native "@" "malloc" 'N 88)
      SodaMem (native "@" "malloc" 'N 258)
      Key (randL 32)
      MonoR NIL
      SodaR NIL )
      (mono_init MonoMem Key)
      (sodium_init SodaMem Key)
      (for N 10
         (println 'N N)
         (mono_update MonoMem Map Size)
         (sodium_update SodaMem Map Size) )
      (test
         (mono_fin MonoMem)
         (sodium_fin SodaMem) )
      (native "@" "free" NIL MonoMem)
      (native "@" "free" NIL SodaMem)
      (munmap Map Size) )

(msg 'ok)
(bye)

