
# >>> 111 - (1130 / -4.0)
# 393.5

(scl 50)

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
(for N 8
   (println (round (task1 N) 6))
)
(println (format (task1 20) *Scl))




(println
   (- 111.0 (*/ 1.0 1130.0 -4.0))
)





(msg 'ok)
(bye)
