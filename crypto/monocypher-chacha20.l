`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de randN NIL
   (rand `(>> -50 1) (dec `(>> -60 1))) )
(msg 'ok)
(bye)
