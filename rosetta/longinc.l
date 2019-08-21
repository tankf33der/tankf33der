(de longinc (Lst)
   (let (D NIL  R NIL)
      (for I Lst
         (cond
            ((< I (last D))
               (for (Y . X) D
                  (T (> X I) (set (nth D Y) I)) ) )
            ((< I (car R))
               (set R I)
               (when D (set (cdr R) (last D))) )
            (T (when R (queue 'D (car R)))
               (push 'R I) ) ) )
      (flip R) ) )

(println
   (longinc (3 2 6 4 5 1)) )
(println
   (longinc (8 4 12 2 10 6 14 1 9 5 13 3 11 7 15)) )

(bye)
