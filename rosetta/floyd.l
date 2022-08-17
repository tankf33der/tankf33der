(de floyd (N)
   (let (A 1  B 1)
      (for X N
         (apply tab (range A B) (need X 3))
         (inc 'A X)
         (inc 'B A) ) ) )
(floyd 5)
(msg 'ok)
(bye)
