(load "@lib/frac.l")
(de yellow (N)
   (let L (list 3 2 1)
      (for N 20
         (and
            (not (member N L))
            (=1 (gcd N (get L 1)))
            (> (gcd N (get L 2)) 1)
            (push 'L N) ) )
      L ) )
(println (yellow))


(msg 'ok)
(bye)
