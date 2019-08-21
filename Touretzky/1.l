#1.1
(test 13 (+ 6 7))
(test 12 (* 4 3))
(test 2 (/ 16 8))
(test 3 (abs -3))

(test -48 (* -8 6))
(test 1 (/ 15 9))
(test 8 (+ 8 0))
(test -1 (- 5 6))
(test
   (2 . 3)
   (f- (frac 1 1) (frac 1 3)) )
(test
   2
   (abs (+ -5 3)) )

#1.2 - ignored

#1.3
(test T (< 7 11))
(test NIL (oddp 12))
(test NIL (== 'KIRK 'SPOCK))
(test NIL (num? 'TWELVE))
(test T (< -4 3))
(test T (bool (=0 0)))
(test NIL (= -9 9))

#1.4
(de sub2 (N)
   (- N 2) )
(test 10 (sub2 12))

#1.5
(de twop (N)
   (=0 (sub2 N)) )
(test 0 (twop 2))
(test NIL (twop 12))

#1.6
(de 1-6-1 (N)
   (/ N 2) )
(de 1-6-2 (N)
   (>> 1 N) )
(test T (= (1-6-1 12) (1-6-2 12)))

#1.7
(de 1-7 (N)
   (> N 9) )
(test T (1-7 12))

#1.8
(de 1-8 (N)
   (- 0 N) )
(test (* -1 12) (1-8 12))

#1.9
(de add2 (X)
   (+ X 2) )
(de twomorep (X Y)
   (= X (add2 Y)) )
(test T (twomorep 12 10))

#1.10
(de 1-10 (X Y)
   (= (sub2 X) Y) )
(test (twomorep 12 10) (1-10 12 10))

#1.11
(de 1-11 (X Y)
   (/ (+ X Y) 2) )
(test 10 (1-11 14 6))

#1.12
(de 1-12 (X Y)
   (> X (/ Y 2)) )
(test T (1-12 11 20))

#1.13
(de 1-13 (N)
   (sym? (bool (num? N))) )
(test (1-13 123) (1-13 'mike))

#1.14
(test T (not NIL))
(test (not 12) (not 'Mike))

#1.15
(de not-onep (N)
   (not (=1 N)) )
(test T (not-onep 11))
(test NIL (not-onep 1))

#1.16
(de not-plusp (N)
   (bool (lt0 N)) )
(test T (not-plusp -11))
(test NIL (not-plusp 11))

#1.17
(de evenp (N)
   (not (oddp N)) )
(test T (evenp 4))
(test NIL (evenp 7))

#1.18
(de add1 (N)
   (+ N 1) )
(de zerop (N)
   (bool (=0 N)) )
(de 1-18 (N)
   (zerop (add1 (add1 N))) )
(test T (1-18 -2))

#1.19
(de 1-19 (S)
   (not (not S)) )
(test NIL (1-19 NIL))
(test T (1-19 T))
(test T (1-19 'rutabaga))

#1.20
(de 1-20 (X Y)
   (and (or X Y) (not (and X Y))) )
(test (xor T NIL) (1-20 T NIL))
(test (xor NIL T) (1-20 NIL T))
(test (xor NIL NIL) (1-20 NIL NIL))
(test (xor T T) (1-20 T T))

#1.21-1.27 - ignored

