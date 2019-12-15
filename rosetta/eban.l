(de eban? (N)
   (let
      (B (/ N 1000000000)
         R (% N 1000000000)
         M (/ R 1000000)
         R (% N 1000000)
         Z (/ R 1000)
         R (% R 1000) )
      (and (>= M 30) (<= M 66) (setq M (% M 10)))
      (and (>= Z 30) (<= Z 66) (setq Z (% Z 10)))
      (and (>= R 30) (<= R 66) (setq R (% R 10)))
      (fully
         '((S)
            (or (bit? 1 (val S)) (>= 6 (val S))) )
         '(B N Z R) ) ) )
(println
   (filter eban? (range 1 1000)) )

(msg 'ok)
(bye)
