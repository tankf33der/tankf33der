#{
(de rec1 (F A L)
   (if L
      (rec1 F (inc 'A (++ L)) L) 
      A ) )
(bench
   (rec1 '+ 0 (range 1 1000000)) )
}#
(de rec2 (F L A)
   (default A 0)
   (if L
      (rec2 F (cdr L) (inc 'A (car L)))
      A ) )
(bench
   (rec2 '+ (range 1 1000000)) )

(de sum1 (L)
   (let N 0
      (for I L
         (inc 'N I) ) ) )
(println (sum1 (range 1 1000000)))
(de sum2 (X)
   (let N 0
      (for I X
         (inc 'N I) ) ) )
(println (sum2 1000000))

(println (sum prog (range 1 1000000)))
      
      

(msg 'ok)
(bye)
