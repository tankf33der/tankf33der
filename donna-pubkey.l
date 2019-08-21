`(== 64 64)
(de donna_pubkey (S)
   (use P
      (native
         "libdonna.so.0"
         "ed25519_publickey"
         NIL
         (cons NIL (32) S)
         '(P (32 B . 32)) )
      P ) )
(setq D
   (make
      (for N 255
         (let L (need 32 0)
            (set L N)
            (do 1000
               (setq L (donna_pubkey L)) )
            (link
               (make
                  (chain (cons N) L) ) ) ) ) ) )
#(rc "crypto/tests/donna-pubkey.rc" 'D D)
(msg 'ok)
(bye)
