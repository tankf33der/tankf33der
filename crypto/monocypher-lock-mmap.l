`(== 64 64)
(de mono-lock (K N CH P PL)
   (let Mac NIL
      (native
         "libmonocypher.so"
         "crypto_lock_aead"
         NIL
         '(Mac (16 B . 16))
         CH
         (cons NIL (32) K)
         (cons NIL (24) N)
         0
         0
         P
         PL )
      Mac) ) 
(de mmap (L F)
   (native "@" "mmap" 'N 0 L 1 2 F 0) )
(de munmap (A L)
   (native "@" "munmap" 'N A L) )
(let 
   (F (car (argv))
      S (car (info F))
      M (mmap S (open F T))
      CH (native "@" "calloc" 'N 1 S)
      Mac (mono-lock
            (need 32 255)
            (need 24 255)
            CH
            M
            S ) )
      (println (struct CH '(B . 16)))
      (println Mac)
      (munmap M S)
      (native "@" "free" NIL CH) )
(bye)
