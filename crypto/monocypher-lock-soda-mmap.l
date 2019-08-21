`(== 64 64)
(de soda-lock (K N CH P PL)
   (let Mac NIL
      (native
         "libsodium.so"
         "crypto_aead_xchacha20poly1305_ietf_encrypt_detached"
         NIL
         CH
         '(Mac (16 B . 16))
         0
         P
         PL
         0
         0
         0
         (cons NIL (24) N)
         (cons NIL (32) K) )
      Mac ) )
(de mmap (L F)
   (native "@" "mmap" 'N 0 L 1 2 F 0) )
(de munmap (A L)
   (native "@" "munmap" 'N A L) )
(let 
   (F (car (argv))
      S (car (info F))
      M (mmap S (open F T))
      CH (native "@" "calloc" 'N 1 S)
      Mac (soda-lock
            (need 32 255)
            (need 24 255)
            CH
            M
            S ) )
      (println (car (struct CH '((B . 16)))))
      (println Mac)
      (munmap M S)
      (native "@" "free" NIL CH) )
(bye)
