# lets generate random BigInt
(seed (in "/dev/urandom" (rd 8)))
(de rand32 NIL
   (make
      (do 32
         (link (rand 0 255)) ) ) )
(de bigint (L)
   (apply
      |
      (mapcar
         >>
         (-248 -240 -232 -224 -216 -208 -200 -192 -184 -176 -168 -160 -152 -144 -136 -128 -120 -112 -104 -96 -88 -80 -72 -64 -56 -48 -40 -32 -24 -16 -8 0)
         (rand32) ) ) )


(println (bigint))


(msg 'ok)
(bye)
