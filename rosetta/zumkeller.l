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
(let
   (L1 (1 2 3 6)
      L2 (1 2 3 4 6 12) )
   (trace 'sum?)
   #(println (sum? 5 (cdr L1)))
   
   (println (sum? 27 (cdr L2)))
)

(msg 'ok)
(bye)
