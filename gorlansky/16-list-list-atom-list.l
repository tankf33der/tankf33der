#16.1 - ignored

#16.2
(de f16-2 (Lst Add P)
   (conc
      (head (dec P) Lst)
      Add
      (nth Lst P) ) )
(test
   '(1 a b 2 3)
   (f16-2 (1 2 3) '(a b) 2) )

#16.3
(de f16-3 (Lst Add P)
   (insert P Lst Add) )
(test
   '(1 (a b) 2 3)
   (f16-3 (1 2 3) '(a b) 2) )

#16.4 - ignored

#16.5
(de f16-5 (F S Lst)
   (mapcar
      '((A)
         (F '((J) (= A J )) Lst) )
      S ) )
(test
   (2 1)
   (f16-5 cnt '(a b) '(c a b a d)) )

#16.6
(de f16-6 (Lst P Add)
   (conc
      (head (dec P) Lst)
      Add
      (nth Lst (inc P)) ) )
(test
   '((a b) x y z (e f))
   (f16-6 '((a b) (c d) (e f)) 2 '(x y z)) )

#16.7
(de f16-7 (Add P Lst)
   (mapcar
      '((L)
         (append
            (head (dec P) L)
            Add
            (nth L P) ) )
      Lst ) )
(test
   '((1 9 10 2 3) (4 9 10 5 6) (7 9 10 8 9))
   (f16-7 (9 10) 2 '((1 2 3) (4 5 6) (7 8 9))) )

#16.8
(de f16-8 (Add P Lst)
   (mapcar
      '((L)
         (if2 (atom L) (and (pair L) (nth L P))
            NIL
            L
            (append
               (head P L)
               Add
               (nth L (inc P)) )
            L ) )
      Lst ) )
(test
   '((1) (4 5 9 10) (7 8 9 10 9) 11)
   (f16-8 '(9 10) 2 '((1) (4 5) (7 8 9) 11)) )

#16.9 - ignored

