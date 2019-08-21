`(== 64 64)
(de hex2L (H)
   (make
      (for (L H L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de lock_aead (K N P A)
   (let 
      (AL (length A)
         PL (length P)
         Mac NIL
         CH NIL )
      (native
         "libmonocypher.so"
         "crypto_lock_aead"
         NIL
         '(Mac (16 B . 16))
         (if P  # for empty plain data
            (list 'CH (cons PL 'B PL)) 
            0 )
         (cons NIL (32) K)
         (cons NIL (12) N)
         (cons NIL (cons AL) A)
         AL
         (cons NIL (cons PL) P)
         PL )
      (conc CH Mac) ) )
(de unlock_aead (K N M A C)
   (let
      (AL (length A)
         CL (length C)
         P )
      (native
         "libmonocypher.so"
         "crypto_unlock_aead"
         'I
         (if (=0 CL)
            0
            (list 'P (cons CL 'B CL)) )
         (cons NIL (32) K)
         (cons NIL (12) N)
         (cons NIL (16) M)
         (cons NIL (cons AL) A)
         AL
         (cons NIL (cons CL) C)
         CL )
      P ) )
# XXX
# fields: key, nonce, mac, ad, crypt, plain, ?valid
# apply patch
(in "chacha20.csv"
   (until (eof)
      (let L (mapcar hex2L (split (line) ","))
         (when (=0 (car (get L 7)))
            (test
               (get L 6)
               (apply unlock_aead (head 5 L)) )
            (test
               (append (get L 5) (get L 3))
               (lock_aead
                  (get L 1)
                  (get L 2)
                  (get L 6)
                  (get L 4) ) ) ) ) ) )
(msg 'CHACHA-OK)
