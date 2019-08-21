`(== 64 64)
(de hex2L (H)
   (make
      (for (L H L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de crypto_x25519 (S P)
   (use R
      (and
         (=0
            (native
               "libmonocypher.so"
               "crypto_x25519"
               'I
               '(R (32 B . 32))
               (cons NIL (32) S)
               (cons NIL (32) P) ) )
         R ) ) )
(in "x25519_test.csv"
   (until (eof)
      (let
         (SK (prog1 (hex2L (till ",")) (char))
            PK (prog1 (hex2L (till ",")) (char))
            SH (prog (hex2L (line))) )
         (test
            T
            # XXX, WTF ?
            (or
               (= SH (crypto_x25519 SK PK))
               (= SH `(need 32 0)) ) ) ) ) )
(msg 'X25519-OK)
