#4.1
(de make-even (N)
   (if (evenp N) N (inc N)) )
(test
   (make-even 4)
   (make-even 3) )

#4.2
(de further (N)
   (if (=0 N)
      0
      ((if (gt0 N) inc dec) N) ) )
(test 0 (further 0))
(test 124 (further 123))
(test -124 (further -123))

#4.3
(de my-not (A)
   (if A NIL T) )
(test T (my-not))
(test NIL (my-not 123))

#4.4
(de ordered (A B)
   (if (< A B)
      (list A B)
      (list B A) ) )
(test
   (ordered 4 3)
   (ordered 3 4) )

#4.5
(de compare (X Y)
   (cond
      ((= X Y) 'same)
      ((< X Y) 'first-smaller)
      ((> X Y) 'first-bigger) ) )
# third
(test
   'first-bigger
   (compare 9 1) ) 
# second
(test
   'first-smaller
   (compare (+ 2 2) 5) )
# first
(test
   'same
   (compare 6 (* 2 3)) )

#4.6
(de my-abs (X)
   (cond
      ((lt0 X) (- X))
      (T X) ) )
(test
   (my-abs 123)
   (my-abs -123) )

#4.7
# only the second is correct

#4.8
(de emphasize3 (L)
   (cond
      ((= 'good (car L))
         (cons 'great (cdr L)) )
      ((= 'bad (car L))
         (cons 'awful (cdr L)) )
      (T (cons 'very L)) ) )
(test
   '(great day)
   (emphasize3 '(good day)) )
(test
   '(awful day)
   (emphasize3 '(bad day)) )
(test
   '(very long day)
   (emphasize3 '(long day)) )

#4.9
# correct version
(de make-odd (N)
   (cond
      ((not (oddp N)) (inc N))
      (T N) ) )
(test
   3
   (make-odd 3) )
(test
   5
   (make-odd 4) )
(test
   -1
   (make-odd -2) )

#4.10
(de constrain (X MIN MAX)
   (cond
      ((< X MIN) MIN)
      ((> X MAX) MAX)
      (T X) ) )
(de constrain-if2 (X MIN MAX)
   (if2 (< X MIN) (> X MAX)
      NIL
      MIN
      MAX
      X ) )
(test
   (constrain-if2 3 -50 50)
   (constrain 3 -50 50) )
(test
   (constrain-if2 92 -50 50)
   (constrain 92 -50 50) )

#4.11
(de firstzero (L)
   (cond
      ((=0 (car L)) 'first)
      ((=0 (cadr L)) 'second)
      ((=0 (caddr L)) 'third)
      (T 'none) ) )
(test
   'first
   (firstzero (0 1 2)) )
(test
   'second
   (firstzero (1 0 2)) )
(test
   'third
   (firstzero (1 2 0)) )
(test
   'none
   (firstzero (1 2 3)) )

#4.12
(de cycle (X)
   (if (= 99 X) 1 (inc X)) )
(test 78 (cycle 77))
(test 1 (cycle 99))

#4.13
(de howcompute (A B C)
   (cond
      ((= (+ A B) C) 'sum-of)
      ((= (* A B) C) 'product-of)
      (T 'beats-me) ) )
(test 'sum-of (howcompute 1 2 3))
(test 'product-of (howcompute 1 2 2))
(test 'beats-me (howcompute 0 2 3) )

#4.14
(test 'foe (and 'fee 'fie 'foe))
(test 'fee (or 'fee 'fie 'foe))
(test 'foe (or NIL 'foe NIL))
(test NIL (and 'fee 'fie NIL))
(test 'yes (and (== 'abc 'abc) 'yes))
(test T (or (== 'abc 'abc) 'yes))

#4.15
(de geq (A B)
   (>= A B) )
(test NIL (geq 1 2))
(test T (geq 1 1))
(test T (geq 2 1))

#4.16
(de 4-16 (N)
   (if (evenp N)
      (/ N 2)
      (if (gt0 N) (* N N) (* N 2)) ) )
(test 2 (4-16 4))
(test 9 (4-16 3))
(test -6 (4-16 -3))

#4.17
(de family (A B)
   (or
      (and
         (or (== 'boy A) (== 'girl A))
         (== 'child B) )
      (and
         (or (== 'man A) (== 'woman A))
         (== 'adult B) ) ) )
(test NIL (family 'boy 'd))
(test 
   (family 'man 'adult)
   (family 'girl 'child) )

#4.18
(de play (A B)
   (if (== A B)
      'tie
      (if
         (or
            (and (== 'rock A) (== 'scissors B))
            (and (== 'scissors A) (== 'paper B))
            (and (== 'paper A) (== 'rock B)) )
         'first-wins
         'second-wins ) ) )
(test 'first-wins (play 'paper 'rock))
(test 'second-wins (play 'rock 'paper))
(test 'tie (play 'rock 'rock))

#4.19
(de and-v1 (X Y Z W)
   (cond
      ((not X) NIL)
      ((not Y) NIL)
      ((not Z) NIL)
      (T W) ) )
(de and-v2 (X Y Z W)
   (nond
      (X X) 
      (Y Y)
      (Z Z)
      (NIL W) ) )
(de and-v3 (X Y Z W)
   (if X
      (if Y
         (if Z W) ) ) )
(let 
   (L1 (1 2 3 4)
      L2 '(NIL 2 3 4)
      L3 '(1 NIL 3 4)
      L4 '(1 2 NIL 4)
      L5 '(1 2 3 NIL) )
   (test
      T
      (=
         (and-v1 L1)
         (and-v2 L1)
         (and-v3 L1) ) )
   (test
      T
      (=
         (and-v1 L2)
         (and-v2 L2)
         (and-v3 L2) ) )
   (test
      T
      (=
         (and-v1 L3)
         (and-v2 L3)
         (and-v3 L3) ) )
   (test
      T
      (=
         (and-v1 L4)
         (and-v2 L4)
         (and-v3 L4) ) )
   (test
      T
      (=
         (and-v1 L5)
         (and-v2 L5)
         (and-v3 L5) ) )
   (test T (= (and-v1) (and-v2) (and-v3))) )

#4.20
(de compare-v1 (A B)
   (if (= A B)
      'same
      (if (< A B)
         'first-smaller
         'first-bigger ) ) )
(de compare-v2 (A B)
   (or
      (and (= A B) 'same)
      (and (< A B) 'first-smaller)
      'first-bigger ) )
(test
   (compare-v1 2 2)
   (compare-v2 2 2) )
(test
   (compare-v1 1 2)
   (compare-v2 1 2) )
(test
   (compare-v1 2 1)
   (compare-v2 2 1) )

#4.21
(de gtest-v1 (A B)
   (if (> A B)
      T
      (if (=0 A)
         T
         (bool (=0 B)) ) ) )
(de gtest-v2 (A B)
   (cond
      ((or (> A B) (=0 A)) T)
      (T (bool (=0 B))) ) )
(test
   (gtest-v1 1 2)
   (gtest-v2 1 2) )
(test
   (gtest-v1 2 1)
   (gtest-v2 2 1) )
(test
   (gtest-v1 -1 0)
   (gtest-v2 -1 0) )

#4.22
(de boilingp-v1 (Temp Scale)
   (cond
      ((and (> Temp 212) (== 'F Scale)) T)
      ((and (> Temp 100) (== 'C Scale)) T) ) )
(de boilingp-v2 (Temp Scale)
   (or
      (and (> Temp 212) (== 'F Scale))
      (and (> Temp 100) (== 'C Scale)) ) )
(de boilingp-v3 (Temp Scale)
   (if (and (> Temp 212) (== 'F Scale))
      T
      (if (and (> Temp 100) (== 'C Scale))
         T ) ) )
(test
   T
   (=
      (boilingp-v1 1223 'C)
      (boilingp-v2 1223 'C)
      (boilingp-v3 1223 'C) ) )
(test
   T
   (=
      (boilingp-v1 212 'F)
      (boilingp-v2 212 'F)
      (boilingp-v3 212 'F) ) )
(test
   T
   (=
      (boilingp-v1)
      (boilingp-v2)
      (boilingp-v3) ) )

#4.23-4.28 - ignored

#4.29
(de logical-and-v1 (X Y)
   (if X
      (if Y T) ) )
(de logical-and-v2 (X Y)
   (bool (and X Y)) )
(test
   (logical-and-v1 'A 'A)
   (logical-and-v2 'A 'A) )

#4.30
(de logical-or (X Y)
   (ifn X
      (if Y T)
      T ) )
(test
   (logical-or NIL NIL)
   (bool (or NIL NIL)) )
(test
   (logical-or 1 NIL)
   (bool (or 1 NIL)) )
(test
   (logical-or NIL 1)
   (bool (or NIL 1)) )
(test
   (logical-or 1 1)
   (bool (or 1 1)) )

#4.31-4.39 - ignored

