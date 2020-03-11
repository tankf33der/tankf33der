`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de elli (S)
   (use R
      (native
         "libmonocypher.so"
         "crypto_elligator2_direct"
         NIL
         '(R (32 B . 32))
         (cons NIL (32) S) )
      R ) )
# https://github.com/signalapp/libsignal-protocol-c/tree/master/src/curve25519/ed25519/tests
(test
   (need 32 0)
   (elli (need 32 0)) )
(test
   (hex2L "5f3520001c6c9936a31206afe7c7ac224e8861619bf98872444915899d95f46e")
   (elli (range 0 31)) )
(msg 'ok)
(bye)
