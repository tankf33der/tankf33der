#18.1
(de f18-1 (L1 L2 N M)
   (- (get L1 N) (get L2 M)) )
(test
   1
   (f18-1 (2 4 6) (1 3 5) 1 1) )

#18.2
(de f18-2 (F X L1 L2)
   (filter
      '((N) (< N X))
      (mapcar F L1 L2) ) )
(test
   (11 44)
   (f18-2 * 50 (1 2 3) (11 22 33)) )

#18.3
(de f18-3 (A B . @)
   (filter
      '((N) (and (=0 (% N A)) (=0 (% N B))))
      (fish atom (rest)) ) ) 
(test
   (6 12 6 12)
   (f18-3 2 3 (6 12) (6 7) (11 12)) )

#18.4
(de f18-4 (D . @)
   (filter
      '((N)
         (fully '((X) (=0 (% N X))) D) )
      (fish atom (rest)) ) )
(test
   (30 300)
   (f18-4 (2 3 5) (30 40) (300 400)) )

#18.5
(de f18-5 (Lst Add P C N)
   (and
      (= C (get Add N))
      (append
         (head P Lst)
         Add
         (nth Lst (inc P)) ) ) )

(test
   '(1 2 a b 3 4 5)
   (f18-5 (1 2 3 4 5) '(a b) 2 'b 2) )
(test
   NIL
   (f18-5 (1 2 3 4 5) '(a b) 2 'b 3) )

