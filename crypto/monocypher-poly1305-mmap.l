`(== 64 64)
(de mono_poly (M ML K)
   (let R NIL
      (native
         "libmonocypher.so"
         "crypto_poly1305"
         NIL
         '(R (16 B . 16))
         M
         ML
         (cons NIL (32) K) )
      R ) )
(de sodium_poly (M ML K)
   (let R NIL
      (native
         "libsodium.so"
         "crypto_onetimeauth_poly1305"
         'I
         '(R (16 B . 16))
         M
         ML
         (cons NIL (32) K) )
      R ) )
(de mmap (L F)
   (native "@" "mmap" 'N 0 L 1 2 F 0) )
(de munmap (A L)
   (native "@" "munmap" 'N A L) )
(let 
   (F (car (argv))
      S (car (info F))
      M (mmap S (open F T))
      Mono (mono_poly M S (need 32 255))
      Soda (sodium_poly M S (need 32 255)) )
      (test Mono Soda)
      (munmap M S) )

(msg 'ok)
(bye)

