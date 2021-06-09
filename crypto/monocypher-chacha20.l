`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de mono-chacha20 (P K N)
   (default P (need 64 0))
   (let (PL (length P)  R)
      (native
         "libmonocypher.so"
         "crypto_chacha20"
         NIL
         (list 'R (cons PL 'B PL))
         (ifn P 0 (cons NIL (cons PL) P))
         PL
         (cons NIL (32) K)
         (cons NIL (8) N) )
      R ) )

(let
   (K (randL 32)
      C (mono-chacha20 NIL K (need 8 0)) )
   (println (get C 33) C)
)




(msg 'ok)
(bye)
