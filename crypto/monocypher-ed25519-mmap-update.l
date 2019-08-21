`(== 64 64)
(load "sodium-ed25519.l")
(de public_key (S)
   (use P
      (native
         "libmonocypher.so"
         "crypto_sign_public_key"
         NIL
         '(P (32 B . 32))
         (cons NIL (32) S) )
      P ) )
(de sign_mono (S P D Size)
   (let Sign NIL
      (native
         "libmonocypher.so"
         "crypto_sign"
         NIL
         '(Sign (64 B . 64))
         (cons NIL (32) S)
         (cons NIL (32) P)
         D
         Size )
      Sign ) )
(de sign_init1 (C Prv Pub)
   (native
      "libmonocypher.so"
      "crypto_sign_init_first_pass"
      NIL
      C
      (cons NIL (32) Prv)
      (cons NIL (32) Pub) ) )
(de sign_init2 (C)
   (native
      "libmonocypher.so"
      "crypto_sign_init_second_pass"
      NIL
      C ) )
(de sign_update (C D S)
   (native
      "libmonocypher.so"
      "crypto_sign_update"
      NIL
      C
      D
      S ) )
(de sign_final (C)
   (let Sign NIL
      (native
         "libmonocypher.so"
         "crypto_sign_final"
         NIL
         C
         '(Sign (64 B . 64)) )
      Sign ) )
(de check_init (C Sig P)
   (native
      "libmonocypher.so"
      "crypto_check_init"
      NIL
      C
      (cons NIL (64) Sig)
      (cons NIL (32) P) ) )
(de check_update (C D S)
   (native
      "libmonocypher.so"
      "crypto_check_update"
      NIL
      C
      D
      S ) )
(de check_final (C)
   (native
      "libmonocypher.so"
      "crypto_check_final"
      'I
      C ) )
(de mmap (L F)
   (native "@" "mmap" 'N 0 L 1 2 F 0) )
(de munmap (A L)
   (native "@" "munmap" 'N A L) )
(let 
   (F (car (argv))
      Size (car (info F))
      Map (mmap Size (open F T))
      MonoSignMem (native "@" "malloc" 'N 984)
      MonoCheckMem (native "@" "malloc" 'N 952)
      Sk (range 1 32) 
      Pk (public_key Sk)
      Sig NIL )
      
      (soda_start)
      #(soda_init SodaMem)
      (sign_init1 MonoSignMem Sk Pk)
      (for N 10
         (println 1 N)
         (sign_update MonoSignMem Map Size)
      )
      #(soda_update SodaMem (sha512_fin Sha512)) 
      (sign_init2 MonoSignMem)
      (for N 10
         (println 2 N)
         (sign_update MonoSignMem Map Size)
      )
      (setq Sig (sign_final MonoSignMem))

      (check_init MonoCheckMem Sig Pk)
      (for N 10
         (println 'check N)
         (check_update MonoCheckMem Map Size) )
      (test 0 (check_final MonoCheckMem))

      (native "@" "free" NIL MonoSignMem)
      (native "@" "free" NIL MonoCheckMem)
      (native "@" "free" NIL Sha512)
      (munmap Map Size) )

(msg 'ok)
(bye)

