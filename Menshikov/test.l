(load "@lib/simul.l")

(de prime? (N)
   (or
      (= N 2)
      (and
         (> N 1)
         (bit? 1 N)
         (let S (sqrt N)
            (for (D 3  T  (+ D 2))
               (T (> D S) T)
               (T (=0 (% N D)) NIL) ) ) ) ) )

(de cacheset ("Cache" Key Val)
   (if (cache "Cache" Key)
      (set @ Val)
      (cache "Cache" Key Val) ) )

(load "1.l")
(load "2.l")
(load "3.l")
(load "4.l")
(msg 'OK-Menshikov)
