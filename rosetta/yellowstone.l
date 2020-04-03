(load "@lib/frac.l")
(de yellow1 (N)
   (let L (list 3 2 1)
      (for N 20
         (and
            (or
               (get L N)
               (not (member N L)) )
            (=1 (gcd N (get L 1)))
            (> (gcd N (get L 2)) 1)
            (push 'L N) ) )
      L ) )
# (println (yellow))

(de yellow (N)
   (let (L (list 3 2 1)  I 4)
      (while (> N (length L))
         # (println (> I (length L)) (not (get L I)) 'I I 'L L 'Len (length L))
         # (wait 10)
         (when
            (and
               (> I (length L))
               (not (get L I))
               (not (member I L))
               (=1 (gcd I (get L 1)))
               (> (gcd I (get L 2)) 1) )
            (push 'L I)
            (setq I 4)
         )
         (inc 'I) )
      (flip L) ))
(println (yellow 20))




(msg 'ok)
(bye)
