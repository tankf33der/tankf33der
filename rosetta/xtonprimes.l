(load "@lib/simul.l")

(de prime? (N Lst)
   (let S (sqrt N)
      (for D Lst
         (T (> D S) T)
         (T (=0 (% N D)) NIL) ) ) )
(de take (N)
   (let I 3 
      (make
         (link 2)
         (while (> N I)
            (and (prime? I (made)) (link I))
            (inc 'I 2) ) ) ) )
(de xton (N C)
   (find
      '((L) (= N (sum prog L)))
      (subsets C (take N)) ) )

(println (xton 19 3))
 
(msg 'ok)
(bye)
