`(== 64 64)
(de soda_pubkey (S)
   (use P
      (native
         "libsodium.so"
         "crypto_scalarmult_base"
         NIL
         '(P (32 B . 32))
         (cons NIL (32) S))
      P ) )
(setq D
   (make
      (for N 255
         (let L (need 32 0)
            (set L N)
            (do 1000
               (setq L (soda_pubkey L)) )
            (link
               (make
                  (chain (cons N) L) ) ) ) ) ) )
(rc "crypto/tests/soda-pubkey.rc" 'D D)
(msg 'ok)
(bye)
