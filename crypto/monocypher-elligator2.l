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
   (do 100000
      (setq L (elli L)) )
   (test
      (23 245 231 184 191 85 163 199 230 245 203 18 82 17 157 66 181 208 86 178 61 183 71 28 254 16 47 69 171 3 251 117)
      L ) )
(msg 'ok)
(bye)
