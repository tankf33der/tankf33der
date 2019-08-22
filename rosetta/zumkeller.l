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
      (and
         (not (bit? 1 S))
         (sum?
            (- (/ S 2) (car L))
            (cdr L) ) ) ) )
(zero C)
(for (I 2 (> 220 C) (inc I))
   (when (zum? I)
      (prin (align 3 I) " ")
      (inc 'C)
      (and
         (=0 (% C 20))
         (prinl) ) ) )
(zero C)
(for (I 1 (> 40 C) (inc 'I 2))
   (when (zum? I)
      (prin (align 7 I) " ")
      (inc 'C)
      (and
         (=0 (% C 8))
         (prinl) ) ) )


(msg 'ok)
(bye)
