# https://www.rosettacode.org/wiki/Additive_primes
(de prime? (N)
   (let D 0
      (or
         (= N 2)
         (and
            (> N 1)
            (bit? 1 N)
            (for (D 3  T  (+ D 2))
               (T (> D (sqrt N)) T)
               (T (=0 (% N D)) NIL) ) ) ) ) )
(de additive (N)
   (and
      (prime? N)
      (prime? (sum prog (mapcar format (chop N)))) ) )
(let (N 0  C 0)
   (loop
      (T (> N 500))
      (when (additive (inc 'N))
         (printsp N)
         (inc 'C) ) )
   (prinl)
   (prinl "Total count: " C) )
(msg 'ok)
(bye)
