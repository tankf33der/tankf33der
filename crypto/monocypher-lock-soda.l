`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de lock_mono (K N P PL A AL)
   (let (Mac NIL  CH NIL)
      (native
         "libmonocypher.so"
         "crypto_lock_aead"
         NIL
         '(Mac (16 B . 16))
         (if (gt0 PL)  # for empty plain data
            (list 'CH (cons PL 'B PL)) 
            0 )
         (cons NIL (32) K)
         (cons NIL (24) N)
         (if (gt0 AL)
            (cons NIL (cons AL) A)
            0 )
         AL
         (if (gt0 PL)
            (cons NIL (cons PL) P)
            0 )
         PL )
      (conc CH Mac) ) )
(de lock_soda (K N P PL A AL)
   (let (Mac1 NIL  CH1 NIL)
      (native
         "libsodium.so"
         "crypto_aead_xchacha20poly1305_ietf_encrypt_detached"
         NIL
         (if (gt0 PL)
            (list 'CH1 (cons PL 'B PL))
            0 )
         '(Mac1 (16 B . 16))
         0
         (if (gt0 PL)
            (cons NIL (cons PL) P)
            0 )
         PL
         (if (gt0 AL)
            (cons NIL (cons AL) A)
            0 )
         AL
         0
         (cons NIL (24) N)
         (cons NIL (32) K) )
      (conc CH1 Mac1) ) )
(let
   (K (randL 32)
      N (randL 24)
      P (randL 1024)
      A (randL 1024) )
   (for (PL 0 (>= 1024 PL) (inc PL))
      (for (AL 0 (>= 1024 AL) (inc AL))
         (test
            (lock_mono K N P PL A AL)
            (lock_soda K N P PL A AL) ) ) ) )
(msg 'ok)
(bye)
