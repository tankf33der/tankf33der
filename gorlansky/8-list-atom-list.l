#8.1
(de f8-1 (F Lst)
   (mapcar F Lst) )
(test
   (0 1 2)
   (f8-1 dec (1 2 3)) )

#8.2
(de f8-2 (Lst N)
   (mapcar
      '((X) (* X N))
      Lst ) )
(test
   (4 8 12)
   (f8-2 (2 4 6) 2) )

#8.3
(de f8-3 (A Lst)
   (filter
      '((I) (<> I A))
      Lst ) )
(test
   (1 2)
   (f8-3 3 (1 2 3)) )

#8.4
(de f8-4 (A Lst)
   (or (member A Lst) (cons A Lst)) )
(test
   (0 1 2 3)
   (f8-4 0 (1 2 3)) )
(test
   (1 2 3)
   (f8-4 1 (1 2 3)) )

#8.5
(de f8-5 (Lst)
   (make
      (for (L Lst L (cddr L))
         (link (head 2 L)) ) ) )
(test
   '((a b) (c d) (e f))
   (f8-5 '(a b c d e f)) )

#8.6
(de f8-6 (Lst P)
   (head (- P) Lst) )
(test
   (1 2 3)
   (f8-6 (1 2 3 4 5) 2) )

#8.7
(de f8-7 (A Lst)
   (delete A Lst) )
(test
   '(b c (a b c))
   (f8-7 'a '(a b c (a b c))) )
(test
   '((a b) c b c)
   (f8-7 'a '((a b) c a b c)) )

#8.8
(de f8-8 (Lst N)
   (let R NIL
      (for I Lst
         (accu 'R I 1) )
      (sort
         (extract
            '((L)
               (and (= (cdr L) N) (car L)) )
            R ) ) ) )
(test
   (1 2 5)
   (f8-8 '(1 2 3 4 5 5 4 5 1 2 1 2) 3) )

#8.9
(de f8-9 (F Lst)
   (uniq (mapcar F Lst)) )
(test
   (0 5 10)
   (f8-9
      '((N) (/ (- N (% N 10)) 10))
      (1 57 101 102 53 6) ) )
      
#8.10
(de f8-10 (Lst N)
   (make
      (while Lst (link (cut N 'Lst)))) )
(test
   '((1 2) (3 4) (5 6) (7 8) (9 10) (11))
   (f8-10 (range 1 11) 2) )
(test
   '((1 2 3) (4 5 6) (7 8 9) (10 11))
   (f8-10 (range 1 11) 3) )

#8.11
(de f8-11 (Lst N) #N99
   (list (cut N 'Lst) Lst) )
(test
   '((A B (C D) 1) (2 NIL))
   (f8-11 '(A B (C D) 1 2 NIL) 4) )

#8.12
(de f8-12 (F Lst)
   (filter F Lst) )
(test
   (2)
   (f8-12 evenp? (1 2)) )

#8.13
(de f8-13 (A Lst)
   (cond
      ((not Lst) NIL)
      ((= A 1) Lst)
      ((atom (car Lst)) (f8-13 A (cdr Lst)))
      (T
         (conc
            (f8-13 (dec A) (car Lst))
            (f8-13 A (cdr Lst)) ) ) ) )
(let L '((a ((b (c) d))) (a ((b (c) d))))
   (test
      '((a ((b (c) d))) (a ((b (c) d))))
      (f8-13 1 L) )
   (test 
      '(c c)
      (f8-13 5 L) ) )

#8.14
(de f8-14 (Lst F)
   (make
      (for I Lst
         (NIL (F I))
         (link I) ) ) )
(test
   (2 4 6)
   (f8-14 (2 4 6 5 7 4) evenp?) )

#8.15
(de f8-15 (Lst A)
   (cond
      ((not Lst) NIL)
      ((atom (car Lst)) (cons (car Lst) (f8-15 (cdr Lst) A)))
      ((=0 A) (f8-15 (cdr Lst) A))
      (T
         (cons
            (f8-15 (car Lst) (dec A))
            (f8-15 (cdr Lst) A) ) ) ) )
(test
   '(5 (4) (1 7) (8))
   (f8-15 '(5 (4 (6)) (1 7) (8 (3 (5)))) 1) )
(test
   '(5 (4 (6)) (1 7) (8 (3 (5))))
   (f8-15 '(5 (4 (6)) (1 7) (8 (3 (5)))) 3) )

#8.16
(de f8-16 (Lst N)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L)
               (inc 'L N)
               (mapcar recurse L) ) ) )
      Lst ) )
(test
   (11 12 13)
   (f8-16 (1 2 3) 10) )
(test
   (11 (12) (13 (14)) 15)
   (f8-16 '(1 (2) (3 (4)) 5) 10) )

#8.17
(de f8-17 (Lst F)
   (let R NIL
      (for I Lst
         (accu 'R I 1) )
      (extract
         '((L)
            (and
               (>= (cdr L) 2)
               (F (car L))
               (car L) ) )
         R ) ) )
(test
   (1)
   (f8-17 (0 1 0 1) oddp?) )

#8.18
(de f8-18-1 (A Lst)
   (let C 1
      (for (I . X) Lst
         (T (> X A))
         (inc 'C) )
      (insert C Lst A) ) )
(de f8-18-2 (A Lst) # destruct
   (sort (cons A Lst)) )
(let L (1 3 5 8 11)
   (test
      (0 1 3 5 8 11)
      (f8-18-1 0 L) )
   (test
      (1 3 5 7 8 11)
      (f8-18-1 7 L) )
   (test
      (1 3 5 8 11 110)
      (f8-18-1 110 L) )
   (test
      (1 3 5 7 8 11)
      (f8-18-2 7 L) ) )

#8.19
(de f8-19 (Lst A)
   (if (and (atom (car Lst)) (atom A))
      (cons A (cdr Lst))
      (append (head (dec (length Lst)) Lst) (cons A)) ) )
(test
   '(z b c)
   (f8-19 '(a b c) 'z) )
(test
   '(a b (1))
   (f8-19 '(a b c) (1)) )

#8.20
(de f8-20 (Lst A)
   (make
      (for (I . X) Lst
         (and
            (= X A)
            (link I X) ) ) ) )
(test
   '(2 a 5 a 8 a)
   (f8-20 '(1 a b 3 a c f a) 'a) )

#8.21
(de f8-21 (Lst N) # N99
   (mapcan '((L) (need N L)) Lst) )
(test
   (1 1 1 1 2 2 2 2 3 3 3 3)
   (f8-21 (1 2 3) 4) )

#8.22
(de f8-22 (Lst N)
   (head (- N) Lst) )
(test
   (1 2 3)
   (f8-22 (1 2 3 4 5) 2) )

#8.23
(de f8-23-2 (Lst N) # destruct
   (do N (rot Lst)) )
(de f8-23-1 (Lst N)
   (let L (dec (length Lst))
      (do N
         (setq Lst
            (cons (last Lst) (head L Lst)) ) ) ) )
(let L '(a b c d e)
   (test
      (f8-23-1 L 2) 
      (f8-23-2 L 2) ) )
     
#8.24
(de f8-24 (Lst N)
   (head N Lst) )
(test
   (1 2)
   (f8-24 (1 2 3 4) 2) )

#8.25
(de f8-25 (Lst F)
   (make
      (for I Lst
         (and (F I) (link '@))
         (link I) ) ) )
(test
   '(1 @ 0 @ -2 3 @ 0 @ -4 5)
   (f8-25 '(1 0 -2 3 0 -4 5) evenp?) )
(test
   '(@ 1 @ 0 -2 @ 3 @ 0 -4 @ 5)
   (f8-25 '(1 0 -2 3 0 -4 5) ge0) )

#8.26
(de f8-26 (Lst F)
   (mapcar
      '((A) (if (F A) A '*))
      Lst ) )
(test
   '(* 1)
   (f8-26 '(a 1) num?) )
(test
   '(* *)
   (f8-26 '(1 0) '((X) (< X 0))) )

#8.27
(de f8-27 (Lst N)
   (extract
      '((A)
         (if (atom A)
            A
            (mapcan
               '((I) (and (<= I N) (cons I)))
               A ) ) )
      Lst ) )
(test
   '(1 2 (3 4) 8 9 (5 1))
   (f8-27 '(1 2 (3 4 7) 8 9 (5 1)) 5) )

#8.28
(de f8-28 (Lst A)
   (filter
      '((I) (<> I A))
      Lst ) )
(test
   '(b c)
   (f8-28 '(a b a c) 'a) )

#8.29
(de f8-29 (Lst N)
   (do N
      (setq Lst
         (append (cdr Lst) (cons (car Lst))) ) )
   Lst )
(test
   '(c d e a b)
   (f8-29 '(a b c d e) 2) )

#8.30
(def 'f8-30 f8-23-1)
(test
   (4 5 1 2 3)
   (f8-30 (1 2 3 4 5) 2) )

#8.31
(de f8-31 (Lst N)
   (head N Lst) )
(test
   (1 2)
   (f8-31 (1 2 3) 2) )

#8.32
(de f8-32 (A Lst)
   (mapcon
      '((L)
         (and
            (or (= (car L) A) (not (= (cadr L) A)))
            (cons (car L)) ) )
      Lst ) )
(test
   (7 7 7 3)
   (f8-32 7 (7 2 7 7 3)) )
(test
   (1 2 3)
   (f8-32 7 (1 2 3)) )

#8.33
(de f8-33 (Lst N)
   (if Lst
      (cons (car Lst) (f8-33 (cdr Lst) N))
      (cons N) ) )
(test
   (1 2 3 4 5)
   (f8-33 (1 2 3 4) 5) )

#8.34
(de f8-34 (N Lst)
   (make
      (for (I . X) Lst
         (and
            (oddp? I)
            (link (f/ (frac X 1) (frac N 1))) ) ) ) )
(test
   '((1 . 3) (1 . 1) (5 . 3) (7 . 3))
   (f8-34 3 (1 2 3 4 5 6 7)) )

#8.35
(de f8-35 (P Lst)
   (remove P Lst) )
(test
   (0 1 3 4)
   (f8-35 3 (0 1 2 3 4)) )

#8.36
(de f8-36 (A Lst)
   (let (N -1  M NIL)
      (recur (Lst N)
         (if (atom Lst)
            (and (= N A) (push 'M Lst))
            (recurse (car Lst) (inc N))
            (and (cdr Lst) (recurse @ N)) ) )
      M ) ) 
(let L '(a (b (c 1) d e) f ((2 (g)) 3))
   (test
      '(f a)
      (f8-36 0 L) )
   (test
      '(3 e d b)
      (f8-36 1 L) )
   (test
      '(2 1 c)
      (f8-36 2 L) ) )

#8.37
(de f8-37 (A Lst)
   (if (member A Lst)
      (mapcar dec Lst)
      Lst ) )
(test
   (0 1 2 3 4 5)
   (f8-37 2 (1 2 3 4 5 6)) )
(test
   (1 2 3 4 5 6)
   (f8-37 0 (1 2 3 4 5 6)) )

#8.38
(de f8-38 (Lst)
   (mapcar '((N) (* N N)) Lst) )
(test
   (1 4 9)
   (f8-38 (1 2 3)) )

#8.39
(de f8-39 (Lst N)
   (mapcar
      '((X)
         (or
            (=0 X)
            ((if (gt0 X) inc dec) 'X N) ) )
      Lst ) )
(test
   (-2 0 2)
   (f8-39 (-1 0 1) 1) )

#8.40
(de f8-40 (Lst C)
   (make
      (for I (length Lst)
         (for L (subsets I Lst)
            (and (= C (sum prog L)) (link L)) ) ) ) )
(test
   13
   (length (f8-40 (range 9 1) 13)) )

#8.41
(de f8-41 (A Lst)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L) L (mapcar recurse (cons A L))) ) )
      Lst ) )
(test
   '((a b c) (a b (a c d)) (a c d))
   (f8-41 'a '((b c) (b (c d)) (c d))) )

#8.42
(def 'f8-42 f8-32)
(test
   (1 1 1 3)
   (f8-42 1 (1 2 1 1 3)) )

#8.43
(de f8-43 (Str D)
   (uniq
      (filter
         '((W) (not (member W D)))
         (str Str) ) ) )
(test
   '(He has our seas ravaged burnt and the of people.)
   (f8-43 "He has plundered our seas, ravaged our coasts,
      burnt our towns, and destroyed the lives of our people."
      '(plundered coasts towns destroyed lives people) ) ) 

#8.44
(de f8-44 (N M)
   (let R (range N M)
      (list (format R) R) ) )
(test
   '(12345 (1 2 3 4 5))
   (f8-44 1 5) )
     
#8.45 - ignored

#8.46
(de f8-46 (A Lst)
   (if (=0 (last Lst))
      (insert 2 Lst A)
      Lst ) )
(test
   '(1 v 2 0)
   (f8-46 'v (1 2 0)) )
(test
   (1 2 3)
   (f8-46 'v (1 2 3)) )

#8.47 - ignored

#8.48
(de f8-48 (D A)
   (extract
      '((L) (and (> (cdr L) A) (cdr L)))
      D ) )
(test
   (5 6 7)
   (f8-48
      (quote
         (a . 1) (b . 2) (c . 3) (d . 4)
         (e . 5) (f . 6) (g . 7) )
      4 ) )

#8.49
(de f8-49 (N Lst)
   (remove N Lst) )
(test
   (1 2 3 4 5 6 7 8 9 10 11 12 13)
   (f8-49 14 (1 2 3 4 5 6 7 8 9 10 11 12 13)) )
(test
   (1 2 3 4 5 6 7 8 9 10 11 12 13)
   (f8-49 14 (1 2 3 4 5 6 7 8 9 10 11 12 13 14)) )
(test
   (1 2 3 4 5 6 7 8 9 10 11 12 13 15)
   (f8-49 14 (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)) )

#8.50
(de f8-50 (F Lst)
   (make
      (for (L Lst L (cddr L))
         (link (F (car L) (cadr L))) ) ) )
(test
   '((1 2) (3 4) (5 6))
   (f8-50 list (range 1 6)) )
(test
   (3 7 11)
   (f8-50 + (range 1 6)) )
(test
   (-1 -1 -1)
   (f8-50 - (range 1 6)) )
(test
   (2 12 30)
   (f8-50 * (range 1 6)) )
(test
   (1 81 15625)
   (f8-50 ** (range 1 6)) )

#8.51
(de f8-51 (Lst N)
   (filter
      '((X) (not (=0 (% X N))))
      Lst ) )
(test
   (1 2 4 5 7 8 10)
   (f8-51 (1 2 3 4 5 6 7 8 9 10) 3) )

#8.52
(de f8-52 (A Lst)
   (tail (- (index A Lst)) Lst) )
(test
   '(b c)
   (f8-52 'a '((a b) a b c)) )

#8.53
(de f8-53 (N Lst) # N99
   (mapcan '((L) (need N L)) Lst) )
(test
   '(a a a b b b c c c)
   (f8-53 3 '(a b c)) )

#8.54
(de f8-54 (F Lst)
   (fully F Lst) )
(test
   T
   (f8-54 num? (1 2 3)) )
(test
   NIL
   (f8-54 num? '(1 2 a)) )
(test
   T
   (f8-54 num?) )

#8.55
(de f8-55 (Lst N)
   (sum prog (head N (filter gt0 Lst))) )
(test
   3
   (f8-55 (-10 -10 1 2 3 4) 2) )
(test
   10
   (f8-55 (-10 -10 1 2 3 4) 4) )

#8.56
(def 'f8-56 head)
(test
   (1 -2 3 -4)
   (f8-56 4 (1 -2 3 -4 -7 4 5)) )

#8.57
(de f8-57 (Lst C)
   (let R NIL
      (for I Lst
         (accu 'R I 1) )
      (extract
         '((L) (and (>= (cdr L) C) (car L)))
         R ) ) )
(test
   (7 1 4 9 8 2)
   (f8-57 '(40 2 8 9 4 2 8 9 4 1 4 1 2 8 7 9 7) 2) )

#8.58
(de f8-58 (Lst C) # N99
   (filter
      '((L) (> (length L) C))
      (make
         (let Last NIL
            (for X Lst
               (if (= X (car Last))
                  (conc Last (cons X))
                  (link (setq Last (cons X))) ) ) ) ) ) )
(test
   '((2 2 2) (5 5 5) (7 7 7 7 7))
   (f8-58 (1 2 2 2 3 4 5 5 5 6 7 7 7 7 7 8) 2) )
(test
   '((7 7 7 7 7))
   (f8-58 (1 2 2 2 3 4 5 5 5 6 7 7 7 7 7 8) 4) )

#8.59
(de f8-59 (Lst N)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L)
               (inc 'L ((if (gt0 L) + -) N))
               (mapcar recurse L) ) ) )
      Lst ) )
(test
   '(2 -3 ((4 (-5)) -6) 7)
   (f8-59 '(1 -2 ((3 (-4)) -5) 6) 1) )

#8.60
(de f8-60 (Lst N)
   (make
      (for (L Lst (nth L N) (cdr L))
         (link (apply + (head N L))) ) ) )
(test
   (12 7 9)
   (f8-60 (7 1 4 2 3) 3) )

#8.61
(de f8-61 (Lst N)
   (let C 0
      (for (L Lst (nth L N) (cdr L))
         (let H (head N L)
            (and
               (= (length H) (length (uniq H)))
               (inc 'C) ) ) )
      C ) )
(test
   4
   (f8-61 '(1 1 3 5 4 5 2 3 2 2 1 1 1) 3) )

#8.62
(de f8-62 (F Lst)
   (filter
      '((N) (not (F N)))
      Lst ) )
(test
   (2 4)
   (f8-62 oddp? (1 2 3 4)) )

#8.63
(de f8-63 (F Lst)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L)
               (unless (F L) L)
               (mapcar recurse L) ) ) )
      Lst ) )
(test
   '((NIL) (2 (((NIL)))) ((4)))
   (f8-63 oddp? '((1) (2 (((3)))) ((4)))) )

#8.64
(de f8-64 (Lst A)
   (mapcar
      '((L)
         (recur (L)
            (if2
               (atom L)
               (>
                  (cnt
                     '((N) (= N L))
                     (fish atom Lst) ) 
                  1 )
               A
               L
               NIL
               (mapcar recurse L) ) ) )
      Lst ) )
(test
   '((7 7 7) (4 5 6) (7 7 7))
   (f8-64 '((1 2 3) (4 5 6) (1 2 3)) 7) )

#8.65
(de f8-65 (Lst A)
   (uniq
      (make
         (for (L Lst L (cdr L))
            (and
               (= (car L) A)
               (cadr L)
               (link (cadr L)) ) ) ) ) )
(test
   '(b c)
   (f8-65 '(a b a b a c a) 'a) )

#8.66
(de f8-66 (Lst N)
   (mapcar
      '((L)
         (recur (L)
            (if2 (atom L) (num? L)
               (inc 'L N)
               L
               NIL
               (mapcar recurse L) ) ) )
      Lst ) )
(test
   '(11 a (12 b))
   (f8-66 '(1 a (2 b)) 10) )

#8.67
(def 'f8-67-1 filter)
(de f8-67-2 (F Lst)
   (make
      (for I Lst
         (and (F I) (link I)) ) ) )
(test
   (f8-67-1 evenp? (0 1 2 3)) 
   (f8-67-2 evenp? (0 1 2 3)) )

#8.68
(de f8-68 (P Lst)
   (tail (- P) Lst) )
(test
   (4 5)
   (f8-68 3 (1 2 3 4 5)) )

#8.69
(de f8-69 (A Lst)
   (let N -1
      (recur (Lst N)
         (if2 (atom Lst) (= A Lst)
            N
            Lst
            NIL
            (cons 
               (recurse (car Lst) (inc N))
               (and (cdr Lst) (recurse @ N)) ) ) ) ) )
(test
   '((1 b) 0 (c (2 (3 d))))
   (f8-69 'a '((a b) a (c (a (a d))))) )

#8.70
(de f8-70 (A Lst)
   (mapcar
      '((N) (* N N))
      (filter
         '((N) (not (= N A)))
         Lst ) ) )
(test
   (4)
   (f8-70 1 (1 2)) )

#8.71
(de f8-71 (N Lst)
   (extract
      '((L) 
         (and 
            (> (cadddr L) N)
            (car L) ) )
      Lst ) )
(test
   '(aspirin)
   (f8-71
      3
      (quote
         (aspirin 2 10 6)
         (analgin 3 20 1) ) ) )

