`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de crypto_lock (K N P)
   (let (PL (length P)  C NIL  M NIL)
      (native
         "libmonocypher.so"
         "crypto_lock"
         NIL
         '(M (16 B . 16))
         (if P (list 'C (cons PL 'B PL)) 0)
         (cons NIL (32) K)
         (cons NIL (24) N)
         (cons NIL (cons PL) P)
         PL )
      (conc C M) ) )
(de crypto_lock_init (C K N)
   (native
      "libmonocypher.so"
      "crypto_lock_init"
      NIL
      C
      (cons NIL (32) K)
      (cons NIL (24) N) ) )
(de crypto_lock_update (C P)
   (let (PL (length P)  R)
      (native
         "libmonocypher.so"
         "crypto_lock_update"
         NIL
         C
         (if P (list 'R (cons PL 'B PL)) 0)
         (cons NIL (cons PL) P)
         PL )
      R ) )
(de crypto_lock_final (C)
   (let M NIL
      (native
         "libmonocypher.so"
         "crypto_lock_final"
         NIL
         C
         '(M (16 B . 16)) )
      M ) )
(de crypto_unlock (K N C)
   (let (CL (- (length C) 16)  P)
      (and
         (=0
            (native
               "libmonocypher.so"
               "crypto_unlock"
               'N
               (list 'P (cons CL 'B CL))
               (cons NIL (32) K)
               (cons NIL (24) N)
               (cons NIL (16) (tail 16 C))
               (cons NIL (cons CL) (head CL C))
               CL ) )
         P ) ) )
(let
   (K (range 1 32)
      Txt (randL 10000)
      C (native "@" "malloc" 'N 240)
      R1 )
   (test
      (setq R1 (crypto_lock K K Txt))
      (prog
         (crypto_lock_init C K K)
         (conc
            (crypto_lock_update C Txt)
            (crypto_lock_final C) ) ) )
   (test 
      (crypto_lock K K)
      (prog
         (crypto_lock_init C K K)
         (conc
            (crypto_lock_update C)
            (crypto_lock_final C) ) ) )
   (test
      R1
      (prog
         (crypto_lock_init C K K)
         (conc
            (make
               (for D Txt
                  (chain (crypto_lock_update C (cons D))) ) )
            (crypto_lock_final C) ) ) )
   (native "@" "free" NIL C) )
(do 8192
   (let D (randL (rand 32 8192))
      (test
         D
         (crypto_unlock
            D
            D
            (crypto_lock D D D) ) ) ) )
(for A (range 32 128)
   (let (Z (rand 0 255)  D (need A Z))
      (for X (1 2 4 8 16 32 64 128)
         (map
            '((L)
               (set L X)
               (test
                  D
                  (crypto_unlock
                     D
                     D
                     (crypto_lock D D D) ) )
               (set L Z) )
            D ) ) ) )

(msg 'ok)
(bye)
