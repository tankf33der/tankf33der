(de propdiv (N)
   (make
      (for I N
         (and (=0 (% N I)) (link I)) ) ) )
(de sum? (G L)
   (cond
      ((=0 G) T)
      ((= (car L) G) T)
      ((cdr L)
         (if (> (car L) G)
            (sum? G (cdr L))
            (or
               (sum? (- G (car L)) (cdr L))
               (sum? G (cdr L)) ) ) )
      (T) ) )   
(de zum? (N)
   (let (L (propdiv N)  S (sum prog L))
      (println 'L L 'S S)
      (or
         (bit? 1 S)
         (sum?
            (- (/ S 2) (car L))
            (cdr L) ) ) ) )
#{
(zero C)
(for (I 2 (> 40 C) (inc I))
   (when (zum? I)
      (printsp I)
      (inc 'C)
      (and
         (=0 (% C 20))
         (prinl) ) ) )
}#

(println (zum? 2))

(msg 'ok)
(bye)
