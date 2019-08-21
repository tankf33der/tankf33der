(load "siphash.l")

(de endian (L) # little
   (apply
      |
      (mapcar >> (0 -8 -16 -24 -32 -40 -48 -56) L) ) )

(for N 127
   (println
      (endian
         (siphash24
            (need N 97)
            (range 0 15) ) ) ) )

(msg 'ok)
(bye)
