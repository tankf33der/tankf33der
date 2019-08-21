(de cntA (L N)
   (default N 0)
   (if (not L)
      N
      (cntA 
         (cdr L)
         ((if (= 'a (car L)) inc prog) N) ) ) )
(test 
   (cntA)  
   (cntA '(m i k e)) )
(test 1 (cntA '(a b c)))
(test 2 (cntA '(a n n a)))

(msg 'ok)
(bye)
