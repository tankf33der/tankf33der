(scl 150)
(de task1 (N)
   (cache '(NIL) N
      (cond
         ((= N 1) 2.0)
         ((= N 2) -4.0)
         (T
            (+
               (- 111.0 (*/ 1.0 1130.0 (task1 (- N 1))))
               (*/
                  1.0
                  3000.0
                  (*/
                     (task1 (- N 2))
                     (task1 (- N 1))
                     1.0 ) ) ) ) ) ) )
(for N (list 3 4 5 6 7 8 20 30 50 100)
   (println 'N: N (round (task1 N) 20)) )

(msg 'ok)
(bye)
