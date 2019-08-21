# 1
(de m1 (L)
   (let (N 0  R NIL)
      (recur (L N)
         (if (atom L)
            (accu 'R N 1)
            (recurse (car L) (inc N))
            (and (cdr L) (recurse @ N)) ) )
      R ) )
(test
   '((5 . 1) (4 . 4) (3 . 2) (2 . 1) (1 . 1))
   (m1 '(a (b (c (d e (f) k 15) e)))) )

# 2
(de m2 (L)
   (let (N 1  R NIL)
      (recur (L N)
         (unless (atom L)
            (accu 'R N 1)
            (recurse (car L) (inc N))
            (and (cdr L) (recurse @ N)) ) )
      R ) )
(test
   '((3 . 1) (2 . 2) (1 . 3))
   (m2 '(a (1) ((2)))) )
(test
   '((2 . 2) (1 . 2))
   (m2 '((1) (2))) ) 

# 3 - ignored

# 4
(de m4 (L A)
   (let N 1
      (make
         (recur (L N)
            (if (atom L)
               NIL
               (and
                  (index A (car L))
                  (link (cons N @))
                  (recurse (cdr L) N) )
               (recurse (car L) (inc N))
               (and (cdr L) (recurse @ N)) ) ) ) ) )
(test
   '((2 . 4) (1 . 2))
   (m4 '(((3 3 3 22)) (1 22 3)) 22) )

# 5
(de m5 (L)
   (if (atom L)
      0
      (max (inc (m5 (car L))) (m5 (cdr L))) ) )
(test
   3
   (m5 '(a b (c d (e f) g))) )

# 6
(de m6 (Lst) # rosettacode
   (for (I (cdr Lst)  I  (cdr I))
      (for (J Lst  (n== J I)  (cdr J))
         (T (> (car J) (car I))
            (rot J (offset I J)) ) ) )
   Lst )
(test
   (1 1 1 3 4 5 7 20)
   (m6 (5 3 1 7 4 1 1 20)) )

(bye)
