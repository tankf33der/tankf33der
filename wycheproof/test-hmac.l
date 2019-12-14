`(== 64 64)
(de hex2L (H)
   (make
      (for (L H L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de mono-verify32 (A B)
   (native
      "libmonocypher.so"
      "crypto_verify32"
      'I
      (cons NIL (32) A)
      (cons NIL (32) B) ) )
(de mono-verify64 (A B)
   (native
      "libmonocypher.so"
      "crypto_verify64"
      'I
      (cons NIL (64) A)
      (cons NIL (64) B) ) )
(de mono-hmac (M K)
   (let (ML (length M)  KL (length K)  R)
      (native
         "libmonocypher.so"
         "crypto_hmac_sha512"
         NIL
         '(R (64 B . 64))
         (if K (cons NIL (cons KL) K) 0)
         KL
         (if M (cons NIL (cons ML) M) 0)
         ML )
      R ) )
(in "hmac_test.csv"
   (until (eof)
      (let
         (K (prog1 (hex2L (till ",")) (char))
            M (prog1 (hex2L (till ",")) (char))
            H (prog1 (hex2L (till ",")) (char))
            F (if (=0 (prog1 (read) (line))) 0 -1) )
         (test
            T
            (=
               ((if (= 32 (length H)) 'mono-verify32 'mono-verify64)
                  (mono-hmac M K)
                  H )
               F ) ) ) ) )
(msg 'hmac-ok)
(bye)

