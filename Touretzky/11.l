#11.1
(de it-member-1 (I L)
   (bool (find '((A) (= A I)) L)) )
(de it-member-2 (I L)
   (for A L
      (T (= A I) T) ) )
(test
   (it-member-1 '(a) '(1 2 A (aa)))
   (it-member-2 '(a) '(1 2 A (aa))) )
(test
   (it-member-1 '(a) '(1 (a) 2 A))
   (it-member-2 '(a) '(1 (a) 2 A)) )

#11.2
(de it-assoc (I Lst)
   (find '((L) (= I (car L))) Lst) )
(test
   '(1 bb) 
   (it-assoc 1 '((2 a) (1 bb) (2 cc))) )
(test
   NIL
   (it-assoc 1 '((2 a) (11 bb))) )

#11.3
(de check-all-odd (L)
   (cond
      ((not L) T)
      (T
         (and
            (oddp (car L))
            (check-all-odd (cdr L)) ) ) ) ) 
(test
   NIL
   (check-all-odd (4 4 4)) )
(test
   T
   (check-all-odd (1 3 5)) )

#11.4
(de it-length-1 (Lst)
   (let L 0
      (for I Lst
         (inc 'L) )
      L ) )
(de it-length-2 (Lst)
   (cnt prog Lst) )
(test
   (it-length-1 (1 2 3 44))
   (it-length-2 (1 2 3 44)) )
(test
   (it-length-1)
   (it-length-2) )

#11.5
(de it-nth (N Lst)
   (do (dec N)
      (pop 'Lst) )
   Lst )
(test
   (nth (1 2 3 4) 2)
   (it-nth 2 (1 2 3 4)) )

#11.6
(de it-union-1 (L1 L2)
   (uniq (append L1 L2)) )
(de it-union-2 (L1 L2)
   (let L1 (uniq L1)
      (for I L2
         (or
            (member I L1)
            (push 'L1 I) ) )
      L1 ) )
(test
   (1 2 3 4 5)
   (it-union-1 (1 2 3) (3 4 5)) )
(test
   (5 4 1 2 3)
   (it-union-2 (1 2 2 3) (3 4 5)) )

#11.7 - ignored

#11.8
(de it-reverse (L)
   (let R NIL
      (for I L
         (push 'R I) )
      R ) )
(test
   (3 2 1)
   (it-reverse (1 2 3)) )

#11.9
(de check-all-odd-do (L) # DO is like FOR
   (let R T
      (for I L
         (T (evenp I) (off R)) )
      R ) )
(test
   T
   (check-all-odd-do (1 1 3)) )
(test
   NIL
   (check-all-odd-do (1 3 5 8)) )
(test
   T
   (check-all-odd-do) )

#11.10
(de it-launch ()
   (let (R NIL  C 10)
      (loop
         (NIL (gt0 C))
         (push 'R '+)
         (at
            (0 . 2)
            (push 'R (dec 'C)) ) )
      R ) )
(test
   '(0 + + 1 + + 2 + + 3 + + 4 + + 5 + + 6 + + 7 + + 8 + + 9 + +)
   (it-launch) )

#11.11
(de find-largest (L)
   (let M (car L)
      (for I (cdr L)
         (and
            (> I M)
            (setq M I) ) )
      M ) )
(test
   32
   (find-largest (2 32 2 2) ) ) 

#11.12
(de power-of-2 (N)
   (let R 1
      (do N
         (inc 'R R) )
      R ) )
(test 1 (power-of-2 0))
(test 2 (power-of-2 1))
(test 4 (power-of-2 2))
(test 8 (power-of-2 3))

#11.13
(de first-non-integer (L)
   (for I L
      (NIL (num? I) I) ) )
(test
   NIL
   (first-non-integer (1 2 3)) )
(test
   'a
   (first-non-integer '(1 a 2)) )
(test
   '(a)
   (first-non-integer '(1 (a) 2)) )
   
#11.14-11.21 - ignored

#11.22
(setq *STRAND
   (quote
      (A . T)
      (G . C)
      (T . A)
      (C . G) ) )

# a
(de complement-base (A)
   (cdr (assoc A *STRAND)) )
(test 'T (complement-base 'A))
(test 'A (complement-base 'T))

# b
(de complement-strand (L)
   (mapcar complement-base L) )
(test
   '(T C C A)
   (complement-strand '(A G G T)) )

# c
(de make-double (L)
   (mapcar
      '((A) (assoc A *STRAND))
      L ) )
(test
   '((G . C) (G . C) (A . T) (C . G) (T . A))
   (make-double '(G G A C T)) )

# d
(de count-bases (L)
   (let R NIL
      (for I (fish atom L)
         (accu 'R I 1) )
      R ) )
(test
   '((T . 3) (A . 3) (C . 2) (G . 2))
   (count-bases
      (quote
         (G . C) (A . T) 
         (T . A) (T . A) (C . G) ) ) )
         
# e
(de prefixp (L1 L2)
   (=
      L1
      (head (length L1) L2) ) )
(test
   T
   (prefixp '(G T C) '(G T C A T)) )
(test
   NIL
   (prefixp '(G T C) '(A G G T C)) )

# f
(de appearsp (Lst1 Lst2)
   (let Len (length Lst1)
      (for (L Lst2 L (cdr L))
         (T
            (and
               (== (car Lst1) (car L))
               (= Lst1 (head Len L)) )
            T ) ) ) )
(test
   T
   (appearsp '(C A T) '(G C A T)) )
(test
   T
   (appearsp '(C A T) '(C A T G G)) )
(test
   NIL
   (appearsp '(C A T) '(G C G)) )

# g
(de coverp (L1 L2)
   (let Len (length L1)
      (loop
         (T (not L2) T)
         (NIL (= L1 (head Len L2)))
         (cut Len 'L2) ) ) )
(test
   T
   (coverp '(A G C) '(A G C A G C)) )
(test
   NIL
   (coverp '(A A) '(A)) )
(test
   T
   (coverp '(A)) )
(test
   NIL
   (coverp '(A G C) '(A G C T T G)) )

# h
(de prefix (N L)
   (head N L) )
(test
   '(C G A T)
   (prefix 4 '(C G A T T A G)) )

# g
(de kernel (Lst)
   (let L NIL
      (for N (length Lst)
         (setq L (head N Lst))
         (T (coverp L Lst) L) ) ) )
(test
   '(A G C)
   (kernel '(A G C A G C A G C)) )
(test
   '(A)
   (kernel '(A A A A)) )
(test
   '(A G G T C)
   (kernel '(A G G T C)) )

# j - ignored

