## http://www.eecs.yorku.ca/course_archive/2007-08/S/3401/LispPrograms.pdf
#

# 1
(de mynth (P L)
   (if (=1 P)
      (car L)
      (mynth (dec P) (cdr L)) ) )
(let L (1 2 3)
   (test
      (car (nth L 2))
      (mynth 2 L) ) )

# 2 
(de f2 (L . P) # recursion on indexes
   (recur (L P)
      (and 
         P
         (cons
            (mynth (car P) L)
            (recurse L (cdr P)) ) ) ) )

(de f2-2 (L . P) # recursion on both
   (recur (L P)
      (cond
         ((or (not L) (not P)))
         ((< 1 (car P))
            (recurse (cdr L) (mapcar dec P)) )
         (T (cons (car L) (recurse L (cdr P)))) ) ) )
(de f2-3 (L . P)
   (mapcar '((N) (car (nth L N))) P) )

(let L (2 33 54 134 555)
   (test
      T 
      (=
         (33 134) 
         (f2 L 2 4)
         (f2-2 L 2 4)
         (f2-3 L 2 4) ) ) )

# 3 
(de f3 (F . L)
   (recur (F L)
      (and 
         (fully car L)
         (cons
            (apply F L)
            (recurse F (mapcar cdr L)) ) ) ) )
(de f3-2 (F . L) # destructively
   (make
      (while (fully car L)
         (link (apply F L))
         (map pop L) ) ) )
(test
   (f3 cons (1 2 3) '(a b c))
   (f3-2 cons (1 2 3) '(a b c)) )
(test
   (f3 cons (1 2 3) '(x y))
   (f3-2 cons (1 2 3) '(x y)) )

# 4
(de f4 (L I)
   (ifn I
      L 
      (f4 (mynth (car I) L) (cdr I)) ) )
(let L '((a b c) (11 22 33))
   (test 
      (car (nth L 2 2))
      (f4 L (2 2)) ) )

# 5
(de remove-first (L A)
   (if A L (remove-first (cdr L) T)) )
(de remove-second (L A)
   (default A 1)
   (cond
      ((not L))
      ((= 2 A) (remove-second (cdr L) (inc A)))
      (T (cons (car L) (remove-second (cdr L) (inc A)))) ) )
(de insert-as-second (I L A)
   (default A 1)
   (cond
      ((not L))
      ((= 2 A)
         (cons I (insert-as-second I L (inc A))) )
      (T
         (cons
            (car L) 
            (insert-as-second I (cdr L) (inc A)) ) ) ) )
(test NIL (remove-first))
(test
   (cdr '(a b c))
   (remove-first '(a b c)) )
(test
   (1 3 4 5)
   (remove-second (range 1 5)) )
(test
   '(A B B A)
   (insert-as-second 'B '(A B A)) )

# 6 - same as #1 - WTF?

# 7
(de diagOf (M A)
   (default A 1)
   (and
      M
      (cons
         (mynth A (car M))
         (diagOf (cdr M) (inc A)) ) ) )
(test
   '(A B b a)
   (diagOf
      (quote
         (A B C D)
         (2 B 3 5)
         (3 3 b 6)
         (6 7 s a) ) ) )

# 8 - same as #3

# 9
(de myrev (L)
   (and
      L
      (conc (myrev (cdr L)) (cons (car L))) ) )
(test
   '(4 (3 a) ((2)) 1)
   (myrev '(1 ((2)) (3 a) 4)) )

# 10
(de f10 (L)
   (cond
      ((not L))
      ((atom L) L)
      (T
         (conc
            (f10 (cdr L))
            (cons (f10 (car L))) ) ) ) )
(test
   '((4 3) 4 (b a 2) (0 1))
   (f10 '((1 0) (2 a b) 4 (3 4))) ) 

# 11 - pure boring

# 12
(de first-of-each @
   (let L (rest)
      (recur (L)
         (and L (cons (caar L) (recurse (cdr L)))) ) ) )
(test
   '(1 a d)
   (first-of-each (1 2 3) '(a b c) '(d e f)) )

# 13-14 - no Wilensky book

# 15
(de mysect (S D)
   (nond
      (S)
      ((member (car S) D)
         (mysect (cdr S) D) )
      (NIL
         (cons
            (car S)
            (mysect (cdr S) D) ) ) ) )
(let (L1 (1 2 3 2)  L2 (1 4 2))
   (test
      (sect L1 L2)
      (mysect L1 L2) ) )

# 16
(de mysome (F . L)
   (recur (F L)
      (and
         (fully car L)
         (bool 
            (or
               (apply F (mapcar car L))
               (recurse F (mapcar cdr L)) ) ) ) ) )
(de myevery (F . L)
   (recur (F L)
      (ifn (fully car L)
         T
         (bool
            (and
               (apply F (mapcar car L))
               (recurse F (mapcar cdr L)) ) ) ) ) )
(test
   (mysome = (1 2 3) (3 22 22))
   (not (mysome = (1 2 3) (3 2 22))) )
(test
   NIL
   (mysome num? '(a b c)) )
(test
   T
   (mysome num? '(a b 777 c)) )
(test
   (myevery num? (1 2 3))
   (=
      NIL 
      (myevery num? '(a 1 2 3))
      (myevery num? '(1 2 3 a)) ) )

# 17 - ignored

# 18
(de countRemove (I L)
   (cons (countRemove-help I L) @@) )
(de countRemove-help (I L C)
   (default C 0)
   (cond
      ((not L) (nil (setq @@ C)))
      ((= (car L) I) (countRemove-help I (cdr L) (inc C)))
      (T (cons (car L) (countRemove-help I (cdr L) C))) ) )
(test
   '((2 3) . 3)
   (countRemove 1 (1 2 1 3 1)) )

# 19
(de myflat (L)
   (cond
      ((not L))
      ((atom L) (cons L))
      (T (conc (myflat (car L)) (myflat (cdr L)))) ) )
(de myflat-2 (L)
   (make
      (recur (L)
         (if (atom L)
            (link L)
            (mapcar recurse L) ) ) ) ) 
(let L '((1) 2 ((3)) (4 (5)))
   (test
      T
      (=
         (fish atom L)
         (myflat L)
         (myflat-2 L) ) ) )

# 20-23
# bubble sort
# http://www.cs.toronto.edu/~jm/324S/tut3.html

# 24
(de f24 (L N I)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L)
               L
               (mapcar recurse (insert N L I)) ) ) )
      L ) )
(test
   '((1 777 2 3) ((12 777 23) 777))
   (f24 '((1 2 3) ((12 23))) 2 777) )

(bye)

