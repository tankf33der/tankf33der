(load "@lib/frac.l")
(de yellow (N)
   (let (L (list 3 2 1)  I 4  C 0)
      (while (> N C)
         (when
            (and
               (not (member I L))
               (=1 (gcd I (get L 1)))
               (> (gcd I (get L 2)) 1) )
            (push 'L I)
            (setq I 4)
            (inc 'C)
         )
         (inc 'I) )
      (flip L) ))
(bench (yellow 2000))




(msg 'ok)
(bye)
