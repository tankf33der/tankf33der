(de floyd (N)
   (let
      (A 1
         B 1
         L (inc (length (/ (* N (inc N)) 2))) )
      (for X N
         (apply tab (range A B) (need X L))
         (inc 'A X)
         (inc 'B A) ) ) )
(floyd 5)
(floyd 14)
(msg 'ok)
(bye)
