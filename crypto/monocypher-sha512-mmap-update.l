`(== 64 64)
(load "sodium-ed25519.l")
(de sha512_init (M)
   (native
      "libmonocypher.so.2"
      "crypto_sha512_init"
      NIL
      M ) )
(de sha512_update (M D S)
   (native
      "libmonocypher.so.2"
      "crypto_sha512_update"
      NIL
      M
      D
      S ) )
(de sha512_fin (M)
   (let R NIL
      (native
         "libmonocypher.so.2"
         "crypto_sha512_final"
         NIL
         M
         '(R (64 B . 64)) )
      R ) )
(de mmap (L F)
   (native "@" "mmap" 'N 0 L 1 2 F 0) )
(de munmap (A L)
   (native "@" "munmap" 'N A L) )
(let 
   (F (car (argv))
      Size (car (info F))
      Map (mmap Size (open F T))
      Sha512Mem (native "@" "malloc" 'N 856)
      Sha512_SodaMem (native "@" "malloc" 'N 208) )
      
      (soda_start)
      (sha512_init Sha512Mem)
      (sodium_sha512_init Sha512_SodaMem)
      (for N 10
         (println N)
         (sha512_update Sha512Mem Map Size)
         (sodium_sha512_update Sha512_SodaMem Map Size) )
      (test
         (sha512_fin Sha512Mem)
         (sodium_sha512_fin Sha512_SodaMem) )
      (native "@" "free" NIL Sha512Mem)
      (native "@" "free" NIL Sha512_SodaMem)
      (munmap Map Size) )
(msg 'ok)
(bye)

