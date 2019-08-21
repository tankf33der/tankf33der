# 1
(test
   T
   (=
      'student
      (cadr '(where student ivanov alexey is studying))
      (caaddr '((4110) (group of) (student ivanov (alexey))))
      (car
         (cdddar
            (cdadar '((dmitry (andrey (maxim all are student))))) ) ) ) )

# 2
(test
   T
   (=
      '(x y z)
      (list
         (cadr '(a x c))
         (cadr '(f y))
         (car '(z)) )
      (list
         (cadadr '((a) (b x) (c d)))
         (caar '((y (z))))
         (caadar '((y (z)))) )
      (list
         (cadr '(a x b y))
         (cadddr '(a x b y))
         (cadr '(f z)) ) ) )

# 3
(test
   T
   (=
      'exellent
      (cadr
         (assoc
            'ivanov
            '((subject db) (ivanov exellent) (petrov satisf)) ) ) ) )
(test
   NIL
   (rassoc
      '(ivanov exellent)
      '((db ivanov satisf) (bz petrov exellent)) ) )
(test
   T
   (bool
      (rassoc
         '(ivanov exellent)
         '((db ivanov exellent) (bz petrov exellent)) ) ) )

# 4
(let L '((k l) (m n) a b c (d (e)))
   (test
      'k
      (caar L) )
   (test
      'm
      (caadr L) )
   (test
      'e
      (caadr (last L)) )
   (test
      '(k d n)
      (list
         (caar L)
         (car (last L))
         (cadadr L) ) )
   (test
      '(a d k)
      (list
         (caddr L)
         (car (last L))
         (caar L) ) )
   (test
      '(d (m n) a)
      (list
         (car (last L))
         (list (caadr L) (cadadr L))
         (caddr L) ) ) )

# 5-12 - ignored
# the same as #4

########################################
########################################
########################################
# LABS2.PDF
########################################

# 1
(de s1-1 (L1 L2)
   (filter
      prog
      (mapcan list L1 L2) ) )
(de s1-2 (L1 L2) # no difference who is longer
   (if (and L1 L2)
      (conc
         (list (car L1) (car L2))
         (s1-2 (cdr L1) (cdr L2)) )
      (or L1 L2) ) )

(test
   (s1-1 (1 2 3 4 5) '(a b c))
   (s1-2 (1 2 3 4 5) '(a b c)) )
(test
   (1 2 1 2 1)
   (s1-2 (1 1 1) (2 2)) )
(test
   (2 1 2 1 1)
   (s1-2 (2 2) (1 1 1)) )

# 2
(de s2 (L N K)
   (head (inc K) (nth L N)) )
(test
   (range 3 7)
   (s2 (range 1 9) 3 4) )

# 3
(de s3 (L1 L2)
   (uniq (append L1 L2)) )
(test
   (range 1 7)
   (s3 (range 1 5) (range 4 7)) )

# 4
(de s4 (L1 L2)
   (filter '((L) (member L L2)) L1) )
(let (L1 (range 1 5)  L2 (range 4 7))
   (test
      (sect L1 L2)
      (s4 L1 L2) ) )

# 5
(de s5 (L1 L2)
   (filter '((L) (not (member L L2))) L1) )
(let (L1 (range 1 5)  L2 (range 4 7))
   (test
      (1 2 3)
      (s5 L1 L2) ) )

# 6
(de s6 (Lst)
   (make
      (for (I . X) Lst
         (and
            (bit? 1 I)
            (link X) ) ) ) )
(test
   '(a c e)
   (s6 '(a b c d e)) )

# 7
(de s7 (Lst)
   (let R 0
      (for (I . X) Lst
         (and
            (bit? 1 I)
            (inc 'R X) ) )
      R ) )
(test
   16
   (s7 (2 4 3 1 7 2 4)) )
   
# 8
(de accuN ("V" "N")
   (if (assoc "N" (val "V"))
      (con @ (inc (cdr @)))
      (push "V" (cons "N" 1)) ) )
(de s8 (Lst)
   (let R NIL
      (for X Lst
         (accuN 'R X) )
      (by car sort R) ) )
(test
   '((1 . 3) (2 . 2) (3 . 1) (5 . 2))
   (s8 (1 2 1 1 3 5 2 5)) )
  
# 9
(de s9 (Lst N K)
   (let (R NIL  X NIL  N (circ N K))
      (while Lst
         (setq R
            (append R (cut (pop 'N) 'Lst)) )
         (setq X
            (append X (cut (pop 'N) 'Lst))   ) )
      (list R X) ) )
(test
   '((1 2 6 7 11) (3 4 5 8 9 10))
   (s9 (range 1 11) 2 3) )

# 10
(de s10 (L1 L2 N)
   (append
      (head N L1)
      L2
      (nth L1 (inc N)) ) )
(test
   '(1 2 3 a b c 4 5 6)
   (s10 (range 1 6) '(a b c) 3) )

# 11
(de s11 (Lst)
   (let
      (Len (/ (length Lst) 2)
         H (head Len Lst)
         E (flip (tail Len Lst)) )
      (mapcar * H E) ) )
(test
   (6 10 12)
   (s11 (range 1 6)) )

# 12
(de s12 (L P)
   (make
      (for (I . X) L
         (if (= I (car P))
            (pop 'P)
            (link X) ) ) ) )
(test
   '(a c d f g)
   (s12 '(a b c d e f g) (2 5)) )

# 13
(de s13 (L)
   (let
      (Len (/ (length L) 2)
         H (head Len L)
         E (tail Len L) )
      (mapcar + H E) ) )
(test
   (7 9 11 13 15)
   (s13 (range 1 10)) )

# 14
(de s14 (Lst)
   (make
      (link (pop 'Lst))
      (let? L (reverse Lst)
         (and (cdr L) (link (s14 (flip @))))
         (link (car L)) ) ) )
(test
   '(3 (2 (1) 2) 3)
   (s14 (3 2 1 2 3)) )
(test
   '(a (b (c d) e) f)
   (s14 '(a b c d e f)) )

# 15
(de prec (Op)
   (case Op
      (("*" "/") 3)
      (("+" "-") 2) ) )
(de s15 (Lst) # In memory of Mr.Dijkstra
   (let S NIL
      (make
         (for Op Lst
            (if (num? Op)
               (link @)
               (while (and S (>= (prec (car S)) (prec Op)))
                  (link (pop 'S)) )
               (push 'S Op) ) )
         (while S
            (link (pop 'S))) ) ) )
(test
   '(3 2 * 5 -)
   (s15 '(3 * 2 - 5)) )
(test
   '(3 3 * 1 8 * -)
   (s15 '(3 * 3 - 1 * 8)) )
(test
   '(4 4 12 * + 3 +)
   (s15 '(4 + 4 * 12 + 3)) )

# 16
(de s16 (L)
   (let S NIL
      (for I L
         (if (num? I)
            (push 'S (list 9 (cons @)))
            (let (X (pop 'S)  P (prec I))
               (set S
                  (list
                     P
                     (append
                        ((if (< (caar S) P) cons prog)
                           (cadar S) )
                        (cons I)
                        ((if (<= (car X) P) cons prog)
                           (cadr X) ) ) ) ) ) ) )
      (cadar S) ) )
(test
   '(2 + 3 + 4)
   (s16 '(2 3 + 4 +)) )
(test
   '(2 * 3 * 4)
   (s16 '(2 3 * 4 *)) )
(test
   '((2 + 3) * 4)
   (s16 '(2 3 + 4 *)) )
(test
   '(2 * 3 + 4)
   (s16 '(2 3 * 4 +)) )
(test
   (4 + 4 * 12 + 3)
   (s16 '(4 4 12 * + 3 +)) )
(test
   '(2 * (3 - (4 + 5 * 6)))
   (s16 '(2 3 4 5 6 * + - *)) )
(test
   '((8 + 2 * 5) / (1 + 3 * 2 - 4))
   (s16 '(8 2 5 * + 1 3 2 * + 4 - /)) )
      
# 17
(de s17 (Lst N K M)
   (let L
      (append
         (head M Lst)
         (head K (nth Lst N))
         (tail (- (length Lst) M) Lst) )
      (append
         (head (dec N) L)
         (nth L (+ N K)) ) ) )
(test
   (1 2 7 8 3 4 5 6 9)
   (s17 (range 1 9) 3 4 8) )
(test
   (1 4 5 6 7 2 3 8 9)
   (s17 (range 1 9) 2 2 7) )

# 18
(de s18 (L)
   (cnt '((N) (not (bit? 1 N))) L) )
(test
   4
   (s18 (range 1 9)) )

# 19
(de s19 (L)
   (extract
      '((N)
         (if (bit? 1 N)
            (+ N 1)
            (- N 2) ) )
      L ) )
(test
   (2 0 4 2 6 4 8 6 10)
   (s19 (range 1 9)) )

# 20
(de s20 (L N K)
   (append
      (head (dec N) L)
      (reverse (head (inc K) (nth L N)))
      (nth L (inc (+ N K))) ) )
(test
   (1 2 3 7 6 5 4 8 9)
   (s20 (range 1 9) 4 3) )

# 21
(de s21 (L)
   (cond
      ((not L))
      ((atom L) L)
      ((= (head 3 L) '(a b a))
         (append '(a b b a) (s21 (cdddr L))) )
      (T (cons (s21 (car L)) (s21 (cdr L)))) ) )
(test
   '(a b c d a b b a c (e f (d a b b a) b a b) b a c)
   (s21 '(a b c d a b a c (e f (d a b a) b a b) b a c)) )

(de s22 (L)
   (let R NIL
      (for N L
         (accu 'R N 1) )
      (>
         (cdr (assoc 0 R))
         (cdr (assoc 1 R)) ) ) )
(test
   T
   (s22 (1 0 0 1 0 1 1 0 0)) )

# 23
(de s23 (L)
   (/ (apply + L) (length L)) )
(test
   3
   (s23 (range 1 5)) )

# 24
(de s24 (L)
   (apply mapcar L list) )
(test
   '((1 4 7) (2 5 8) (3 6 9))
   (s24 '((1 2 3) (4 5 6) (7 8 9))) )

# 25
(de s25 (L) # WTF?
   (sort L) )
(test
   (range 1 9)
   (s25 (1 9 4 7 3 6 8 5 2)) )

# 26
# nothing special
# http://rosettacode.org/wiki/Sorting_algorithms/Merge_sort#PicoLisp

(msg 'OK-Stepanoff)

