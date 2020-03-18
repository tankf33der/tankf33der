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
   (95 53 32 0 28 108 153 54 163 18 6 175 231 199 172 34 78 136 97 97 155 249 136 114 68 73 21 137 157 149 244 110)
   (elli (range 0 31)) )
(let L (range 0 32)
   (do 1000
      (setq L (elli L)) )
   (test
      (193 91 249 76 51 122 213 216 248 215 87 33 167 3 15 200 228 178 253 81 233 42 132 130 56 79 6 11 49 60 108 29)
      L ) )
(msg 'ok)
(bye)
