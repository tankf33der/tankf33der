`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de mblake2b_init (M)
   (native
      "libmonocypher.so"
      "crypto_blake2b_init"
      NIL
      M ) )
(de mblake2b_update (M D S)
   (native
      "libmonocypher.so"
      "crypto_blake2b_update"
      NIL
      M
      D
      S ) )
(de mblake2b_fin (M)
   (use R
      (native
         "libmonocypher.so"
         "crypto_blake2b_final"
         NIL
         M
         (cons 'R (cons (cons 64 'B 64))) )
      R ) )
(de soda_init (S)
   (native
      "libsodium.so"
      "crypto_generichash_init"
      NIL
      S
      0
      0
      64 ) )
(de soda_update (S D Size)
   (native
      "libsodium.so"
      "crypto_generichash_update"
      NIL
      S
      D
      Size ) )
(de soda_fin (S)
   (use R
      (native
         "libsodium.so"
         "crypto_generichash_final"
         NIL
         S
         (cons 'R (cons (cons 64 'B 64)))
         64 )
      R ) )
(de mmap (L F)
   (native "@" "mmap" 'N 0 L 1 2 F 0) )
(de munmap (A L)
   (native "@" "munmap" 'N A L) )
(let 
   (F (car (argv))
      Size (car (info F))
      Map (mmap Size (open F T))
      MonoMem (native "@" "malloc" 'N 224)
      SodaMem (native "@" "malloc" 'N 384)
      MonoR NIL
      SodaR NIL )
      (mblake2b_init MonoMem)
      (soda_init SodaMem)
      (for N 10
         (println 'N N)
         (mblake2b_update MonoMem Map Size)
         (soda_update SodaMem Map Size) )
      (test
         (mblake2b_fin MonoMem)
         (soda_fin SodaMem) )
      (native "@" "free" NIL MonoMem)
      (native "@" "free" NIL SodaMem)
      (munmap Map Size) )
(msg 'ok)
(bye)

