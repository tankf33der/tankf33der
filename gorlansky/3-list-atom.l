#3.1
(de f3-1 (A L)
   (cnt
      '((I)
         (= I A) )
      L ) )
(test
   4
   (f3-1 'b '(a b b a b a b) ) )

#3.2
(de f3-2 (L)
   (let S 0
      (or
         (and
            (fully
               '((I)
                  (and (num? (get L I)) (inc 'S @)) )
               (1 3 7) )
            S )
         (last L) ) ) )
(test
   121
   (f3-2 (11 22 33 44 55 66 77)) )
(test
   'mike
   (f3-2 '(11 22 33 44 55 66 7a7 mike)) )
(test
   6
   (f3-2 '(1 2 3 4 5 6)) )
(test
   NIL
   (f3-2) )

#3.3
(de f3-3 (L)
   (sum
      '((I)
         (and (gt0 I) (bit? 1 I) I))
      L ) )
(test
   12
   (f3-3 (0 5 6 7 8)) )

#3.4
(de f3-4 (L)
   (mini char L) )
(test
   'a
   (f3-4 '(b c a)) )

#3.5
(de f3-5 (L)
   (let R NIL
      (mapc
         '((I)
            (accu 'R I 1) )
         L )
     (car (mini cdr R)) ) )
(test
   111
   (f3-5 (111 2 3 3 2)) )

#3.6
(de f3-6 (L1 L2)
   (cond
      ((not L1) T)
      ((member (car L1) L2) (f3-6 (cdr L1) L2)) ) )
(test
   NIL
   (f3-6 (1 2 33) (1 2 3 4)) )
(test
   T
   (f3-6 (2 3) (2 3 4 5)) )

#3.7
(de f3-7 (L)
   (let? L (uniq (fish atom L))
      (and (not (cdr L)) (car L)) ) )
(test
   NIL
   (f3-7) )
(test
   'a
   (f3-7 '(a (a a))) )
(test
   NIL
   (f3-7 '(a (a a b))) )
(test
   NIL
   (f3-7 '((a) (a a b))) )
(test
   'b
   (f3-7 '(((b)) (b))) )

#3.8
(de f3-8 (L)
   (pick prog (fish atom L)) )
(test
   'a
   (f3-8 '((()) (()((a)) (b c)) d)) )

#3.9
(de f3-9-1 (L)
   (num? (caddr L)) )
(de f3-9-2 (L)
   (num? (car (nth L 3))) )
(de f3-9-3 (L)
   (num? (get L 3)) )
(test
   T
   (fully
      '((L)
         (=
            (f3-9-1 L)
            (f3-9-2 L)
            (f3-9-3 L) ) )
      (quote
         (1 2)
         (a a 1 a)
         (a a a a) ) ) )

#3.10
(de f3-10 (L)
   (pick '((N) (bool (bit? 1 N))) L) )
(test
   T
   (f3-10 (2 4 6 4 2 1)) )
(test
   NIL
   (f3-10 (2 4)) )

#3.11
(de f3-11 (L N)
   (default N NIL)
   (cond
      ((not L) N)
      ((bit? 1 (car L)) (f3-11 (cdr L) (car L)))
      (T (f3-11 (cdr L) N)) ) )
(test
   5
   (f3-11 '(1 2 4 5 6 8)) )

#3.12
(de f3-12 (L)
   (cnt
      '((I)
         (fully '((J) (= 5 J)) (cdr I)) )
      L ) )
(test
   1
   (f3-12
      (quote
         (a 5 5 5) 
         (b 5 4 4)
         (c 4 4 3) ) ) )

#3.13
(de f3-13 (L)
   (let R (0 NIL)
      (mapc
         '((I)
            (and
               (= 'm (caddr I))
               (inc R)
               (push (cdr R) (cadddr I)) ) )
         L )
      (/ (apply + (cadr R)) (car R)) ) )
(test
   185
   (f3-13
      (quote
         (Ivanov 92 m 180 80)
         (Petrova 92 f 160 60)
         (Petrov 92 m 190 90) ) ) )

#3.14
(de f3-14 (L)
   (and
      (maxi
         '((I)
            (and (= 'm (caddr I)) (cadddr I)) )
         L )
      @@ ) )
(test
   190
   (f3-14
      (quote
         (Ivanov 92 m 180 80)
         (Petrova 92 f 160 60)
         (Petrov 92 m 190 90) ) ) )

#3.15
(de f3-15 (A B L)
   (let N 0
      (fish
         '((X)
            (nil (and (<= A X B) (inc 'N))) )
         L )
      N ) )
(test
   3
   (f3-15 1 3 '((2 (5 (nil 3 1) 7)))) )

#3.16
(de f3-16 (L)
   (find atom (flip L)) )
(test
   'e
   (f3-16 '((a b c) d e (f g h))) ) 

#3.17
(de f3-17 (L)
   (apply max (fish atom L)) )
(test
   6
   (f3-17 '(1 2 3 (4 5) (((6))) 4 5)) )

#3.18
(de f3-18 (L)
   (and (cdr L) (car (tail 2 L))) )
(test
   2
   (f3-18 (1 2 3)) )
(test
   1
   (f3-18 (1 2)) )
(test
   NIL
   (f3-18 (1)) )
(test
   NIL
   (f3-18) )

#3.19
(de f3-19 (L)
   (= L (reverse L)) )
(test
   NIL
   (f3-19 '(m i k e)) )
(test
   T
   (f3-19 '(1 2 3 2 1)) )

#3.20
(de f3-20 (L)
   (let Last (last L)
      (cnt '((I) (<> I Last)) L) ) )
(test
   2
   (f3-20 '(a b b a)) )

#3.21
(de f3-21 (L)
   (let R (need 2 0)
      (mapc
         '((I)
            (and
               (num? I)
               (inc R I)
               (inc (cdr R)) ) )
         (fish atom L) ) 
      R ) )
(test
   (14 4)
   (f3-21 '(a (2) ((3) b 4) 5)) )

#3.22
(de f3-22 (L1 L2)
   (not (diff L1 L2)) )
(test
   T
   (f3-22 (1 2) (2 1)) )
(test
   NIL
   (f3-22 (1 2) (2 2)) )

#3.23
(de f3-23 (L)
   (sum gt0 L) )
(test
   6
   (f3-23 (2 -3 4 -1 -6)) )

#3.24
(de f3-24 (L)
   (cnt atom L) )
(test
   3
   (f3-24 '(a (a) a (a a) a)) )

#3.25
(de f3-25 (L)
   (apply + (uniq L)) )
(test
   6
   (f3-25 (1 2 3 1 2 3)) )

#3.26
(de f3-26 (L)
   (car (cdr (car (cdr (cdr L))))) )
(let L '(1 (2) ((3 4) 5))
   (test
      T
      (=
         (f3-26 L)
         (car (cdaddr L)) ) ) )

#3.27
(de f3-27 (L)
   (not
      (for (I L (cdr I) (cdr I))
         (NIL (>= (car I) (cadr I)) T) ) ) )
(let (L1 (6 3 2 1)  L2 (3 2 1 4)) 
   (test
      (apply >= L1)
      (f3-27 L1) )
   (test
      (apply >= L2)
      (f3-27 L2) ) )

#3.28
(de f3-28 (L)
   (car (cdr (cdr L))) )
(test
   (caddr (1 2 3)) 
   (f3-28 (1 2 3)) )

#3.29
(de f3-29 (L)
   (length
      (cdr
         (recur (L)
            (if (fully atom L)
               (cons 1 L)
               (maxi recurse L)
               (inc @@)
               @@ ) ) ) ) )
(test
   1
   (f3-29 '((a))) )
(test
   2
   (f3-29 '((a b) 1 ((12 3)) 2)) )

#3.30
(de f3-30 (L)
   (not (bit? 1 (apply + L))) )
(test
   T
   (f3-30 (1 1)) )
(test
   NIL
   (f3-30 (1 1 1)) )

#3.31
(de f3-31 (L)
   (let S 0
      (for (I . X) L
         (and (bit? 1 I) (inc 'S X)) )
      S ) )
(test
   4
   (f3-31 (1 2 3 4)) )
(test
   0
   (f3-31 (3 5 7 9 -10)) )

#3.32
(de f3-32 (L)
   (sum
      '((N) (and (not (bit? 1 N)) N))
      L ) )
(test
   6
   (f3-32 (1 2 3 4)) )

#3.33
(de f3-33 @
   (cnt =0 (rest)) )
(test
   3
   (f3-33 1 0 2 0 3 0 4) )

#3.34
(de f3-34 (L)
   (let P 1
      (mapc
         '((N)
            (and
               (gt0 N)
               (not (bit? 1 N))
               (setq P (* P N)) ) )
         L )
      P ) )
(test
   8
   (f3-34 (0 1 2 3 4)) )

#3.35
(de f3-35 (L)
   (let R (need 2 0)
      (mapc
         '((L)
            (inc R)
            (inc (cdr R) (cadr L)) )
         L )
      (/ (cadr R) (car R)) ) )
(test
   33
   (f3-35
      (quote
         (Mark 40)
         (Kathy 30)
         (Sally 57)
         (Doran 35)
         (Anthony 3) ) ) )

#3.36
(de f3-36 (F . @)
   (bin
      (apply 
         F
         (mapcar '((N) (bin (format N))) (rest)) ) ) )
(test
   "1001001"
   (f3-36 + 1011 111001 101) )
(test
   "-110011"
   (f3-36 - 1011 111001 101) )
(test
   "110000111111"
   (f3-36 * 1011 111001 101) )
(test
   "0"
   (f3-36 / 1011 111001 101) )

#3.37
(de f3-37 (F . @)
   (bin
      (apply
         F
         (mapcar '((N) (bin (pack N))) (rest)) ) ) )
(test
   "1001001"
   (f3-37 
      + 
      (1 0 1 1)
      (1 1 1 0 0 1)
      (1 0 1)) )

#3.38
(de f3-38 (L)
   (length (fish atom L)) )
(test
   5
   (f3-38 '(a (b c (d) e))) )

#3.39 = #3.2
(test
   11
   (f3-2 '(1 2 3 4 5 6 7 8 9 10)) )

#3.40
(de f3-40 (L)
   (sum
      '((N)
         (and (gt0 N) (* 2 N)) )
      L ) )
(test
   8
   (f3-40 (1 -2 3)) )

#3.41
(de f3-41 (L)
   (/ (apply + L) (length L)) )
(test
   12
   (f3-41 (11 12 13)) )

#3.42
(de f3-42 (L)
   (>
      (cnt num? L)
      (cnt sym? L) ) )
(test
   T
   (f3-42 (1 1 a)) )

#3.43
(de f3-43 (L)
   (and (cdr L) (not (cdddr L))) )
(test
   NIL
   (f3-43 '(a)) )
(test
   T
   (f3-43 '(a b)) )
(test
   T
   (f3-43 '(a b c)) )
(test
   NIL
   (f3-43 '(a b c d)) )

#3.44
(de f3-44 (Lst)
   (let N (length Lst)
      (sum
         '((X L) (get L X))
         (range 1 N)
         Lst ) ) )
(test
   3   
   (f3-44
      (quote
         (1 0 0)
         (0 1 0)
         (0 0 1) ) ) )
(test
   4
   (f3-44
      (quote
         (1 0 0 0)
         (0 1 0 0)
         (0 0 1 0)
         (0 0 0 1) ) ) )

#3.45
(de f3-45 (L)
   (cond
      ((not L) 0)
      ((atom (car L)) (f3-45 (cdr L)))
      (T
         (max
            (inc (f3-45 (car L)))
            (f3-45 (cdr L)) ) ) ) )
(test
   0
   (f3-45 (1 2 3)) ) 
(test
   2
   (f3-45 (1 ((2)) 3)) )

#3.46
(de f3-46 (L)
   (not
      (bit?
         1
         (apply + (fish atom L)) ) ) )
(test
   T
   (f3-46 '(1 (2 (3)) (4))) )
(test
   NIL
   (f3-46 '(0 (2 (3)) (4))) )

#3.47
(de f3-47 (L)
   (cond
      ((not L) T)
      ((fully atom (cdr L))
         (or 
            (atom (car L))
            (f3-47 (car L)) ) )
      (T NIL) ) )
(test
   T
   (f3-47 '((((3 4) 5) 6 7) 1)) )
(test
   NIL
   (f3-47 '((((3 4) 5) (6 7) 1))) )

#3.48
(de f3-48 (L)
   (let R NIL
      (mapc
         '((I)
            (accu 'R I 1) )
         L )
      (car (maxi cdr R)) ) )
(test
   1
   (f3-48 (1 1 1 1 2 3 1)) )

#3.49
(de f3-49 (L)
   (car (car (cdr (car (car (car L)))))) )
(let L '((((ddd (aaa)) eee) nnn) kkk)
   (test
      (caar (cdaaar L))
      (f3-49 L) ) )

#3.50
(de f3-50 (L)
   (car (cdr (cdr (cdr L)))) )
(let L '(hhh iii ddd aaa)
   (test
      (cadddr L)
      (f3-50 L) ) )

#3.51
(de f3-51 (L)
   (let C 0
      (while
         (and
            L
            (<> '* (pop 'L))
            (inc 'C) ) )
      C ) )
(test
   4
   (f3-51 '(1 2 3 4 * 6 7)) )

#3.52
(de f3-52 (L)
   (car
      (mini
         '((I) (time (cadr I) (caddr I)))
         L ) ) )
(test
   'Sidorov
   (f3-52
      (quote
         (Ivanov 10 13)
         (Petrov 16 17)
         (Sidorov 10 12) ) ) )

#3.53
(de minmax (L)
   (list
      (mini
         '((I) (time (cadr I) (caddr I))) 
         L )
      (maxi
         '((I) (time (cadr I) (caddr I)))
         L ) ) )
(de f3-53 (L)
   (let M (minmax L)
      (time
         (-
            (time (cdadr M))
            (time (cdar M)) ) ) ) )
(test
   (6 5 0)
   (f3-53
      (quote
         (Ivanov 10 13)
         (Petrov 16 17)
         (Sidorov 10 12) ) ) )

#3.54
(de f3-54 (L A N)
   (default A 1 N 0)
   (cond
      ((not L) (/ A N))
      ((not (car L)) (f3-54 (cdr L) A N))
      (T
         (f3-54
            (cdr L)
            (* A (car L))
            (inc N) ) ) ) )
(test
   27324001339715137104165888000
   (f3-54
      '(NIL 46 45 44 41 NIL 44 45 46 43 44
         47 NIL 46 45 46 46 44 42 41 49 NIL ) ) )

#3.55
(de f3-55 (L)
   (find atom L) )
(test
   'd
   (f3-55 '((a) ((b) c) d)) )
(test
   NIL
   (f3-55 '((a) ((b) c))) )

#3.56
(de f3-56 (L)
   (let P 1
      (mapc
         '((N)
            (or
               (=0 N)
               (bit? 1 N)
               (setq P (* P N)) ) )
         L )
      P ) )
(test
   48
   (f3-56 '(0 1 2 3 4 5 6 7)) )

#3.57
(de f3-57 (L)
   (if (not L) 0 (inc (f3-57 (cdr L)))) )
(let L (1 2 3 4)
   (test
      (length L)
      (f3-57 L) ) )

#3.58
(de f3-58 (L)
   (sum num? L) )
(test
   85
   (f3-58 '(54 gh 5 fd 7 9 12 -2 f)) )

#3.59
(de f3-59 (L)
   (let P 1
      (mapc
         '((N)
            (and (num? N) (setq P (* P N))) )
         L )
      P ) )
(test
   -408240
   (f3-59 '(54 gh 5 fd 7 9 12 -2 f)) )

#3.60
(de f3-60 (L)
   (and
      (maxi
         length
         (split L " ") )
      @@ ) )
(test
   6
   (f3-60 '("t" "e" "s" "t" " " "s" "t" "r" "o" "k" "a" " " "s")) )

#3.61
(de f3-61 (L)
   (let P 1
      (mapc
         '((I)
            (mapc
               '((J)
                  (and
                     (format J)
                     (setq P (* @ P)) ) )
               (chop I) ) )
         L )
      P ) )
(test
   24
   (f3-61 '(a s ss d 1 -2 h3-4d)) )

#3.62
(de f3-62 (L)
   (let P 0
      (mapc
         '((I)
            (mapc
               '((J)
                  (and
                     (format J)
                     (inc 'P @) ) )
               (chop I) ) )
         L )
      P ) )
(test
   18
   (f3-62 '(1a3 e34d w12 r3r1)) )

#3.63
(de f3-63 (L)
   (let (Len (length (car L))  P (range 1 Len))
      (=
         (* 
            Len
            (sum '((L I) (get L I)) L P) )
         (* 
            Len
            (sum
               '((L I) (get L I))
               L
               (reverse P) ) )
         (sum '((L) (apply + L)) L)
         (sum
            '((L) (apply + L))
            (apply mapcar (reverse L) list) ) ) ) )
(test
   T
   (f3-63
      (quote
         (2 9 4)
         (7 5 3)
         (6 1 8) ) ) )
(test
   T
   (f3-63
      (quote
         (4 14 15 1)
         (9 7 6 12)
         (5 11 10 8)
         (16 2 3 13) ) ) )

#3.64
(de f3-64 (L)
   (cnt sym? L) )
(test
   2
   (f3-64 '(a a 1)) )
  
#3.65
(de f3-65 (L)
   (bool
      (seek
         '((L)
            (= (car L) (cadr L)) )
         L ) ) )
(test
   NIL
   (f3-65 (1 2 0)) )
(test
   T
   (f3-65 (1 2 0 0)) )

#3.66
(de posi (L F)
   (let (N (apply F L))
      (cons N (index N L)) ) )
(de f3-66 (L)
   (let (I (posi L min)  A (posi L max))
      (if (< (cdr A) (cdr I))
         (+ (car A) (car I))
         0 ) ) ) 
(test
   10
   (f3-66 '(9 7 6 5 4 3 2 1)) )
(test
   0
   (f3-66 '(7 6 5 4 3 2 1 9)) )
      
#3.67
(de f3-67 (L)
   (if (atom L)
      0
      (max (inc (f3-67 (car L))) (f3-67 (cdr L))) ) )
(test
   3
   (f3-67  '(a b (c d (e f) g))) )

#3.68
(de f3-68 (L)
   (/
      (sum
         '((I) (caddr I))
         L )
      (length L) ) )
(test
   14333
   (f3-68
      (quote
         (Ivanov 2 15000)
         (Petrov 2 12000)
         (Sidorov 2 16000) ) ) )

#3.70
(de f3-70 (L)
   (apply min (filter gt0 L)) )
(test
   1
   (f3-70 (-1 0 1 2)) )
(test
   3
   (f3-70 (3 13 -1 0 -13)) )

#3.71
(de f3-71 (L)
   (dec
      (index
         (maxi '((L) (apply + L)) L)
         L ) ) )
(test
   1
   (f3-71
      (quote
         (1 2 3)
         (1 2 4)
         (1 2 3) ) ) )

#3.72
(de f3-72 (L)
   (sum
      '((I N)
         (and
            (not (bit? 1 N))
            I ) )
      L
      (range 1 (length L)) ) )
(test
   2
   (f3-72 (0 1 0 1 1)) )

#3.73
(de f3-73 (L)
   (let L (fish atom L)
      (= (car L) (last L)) ) )
(test
   T
   (f3-73 '((1 2 3) (4 5 6) (7 8 1))) )
(test
   NIL
   (f3-73 '((1 2 3) (4 5 6) (7 8 9))) )

#3.75 - ignored

#3.76
(de f3-76 (L)
   (dec
      (index
         (mini
            '((L) (apply min L))
            L )
         L ) ) )
(test
   1
   (f3-76 '((1 1) (1 0) (1 1))) )
(test
   2
   (f3-76 '((11 3) (10) (5 0 0))) )

#3.77
(de f3-77 (L)
   (apply + (fish atom L)) )
(test
   5
   (f3-77 '(1 ((1) (1)) (1) 1)) )

#3.78
(de f3-78 (L)
   (apply * (fish atom L)) )
(test
   3456
   (f3-78 '(1 2 3 (3 6) 2 1 (2 4) 2)) )

#3.79
(de f3-79 (L)
   (sum
      '((N) (and (> N 10) N)) 
      L ) )
(test
   23
   (f3-79 '(8 9 10 11 12)) )

#3.80
(de f3-80 (L)
   (let R NIL
      (mapc '((N) (accu 'R N 1)) L)
      (sum
         '((L)
            (and
               (= 2 (cdr L))
               (* (car L) (cdr L)) ) )
         R ) ) )
(test
   10
   (f3-80 '(1 2 3 4 5 2 3)) )

#3.81
(de f3-81 (L)
   (length (fish atom L)) )
(test
   5
   (f3-81 '((a (b) ((c)) d) e)) )

#3.82
(de f3-82 (L)
   (format (pack L)) )
(test
   12334123445
   (f3-82 '(123 34 1234 45)) )

#3.83
(de f3-83 (L)
   (apply * (filter num? (fish atom L))) )
(test
   3456 
   (f3-83 '(1 2 a 3 (3 b 6) 2 1 (2 4 c) 2 d)) )

#3.84
(de 1? (N)
   (= "1" (car (chop N))) )
(de f3-84 (L)
   (sum
      '((N) (and (1? N) N))
      L ) )
(test
   25
   (f3-84 '(12 22 13)) )

#3.85
(de f3-85 (L)
   (cnt
      '((N) (= 2 N))
      (maplist
         '((L)
            (let C 0
               (for (I L I (cdr I))
                  (inc 'C)
                  (NIL (< (car I) (cadr I)) C) ) ) )
         L ) ) )
(test
   2
   (f3-85 (1 2 3 2 3 4 1)) )
(test
   3
   (f3-85 (1 2 3 2 3 4 1 1 7 7)) )
(test
   3
   (f3-85 (1 2 3 2 3 4 1 1 1 7)) )
(test
   2
   (f3-85 (1 2 3 3 1 2 3)) )
(test
   1
   (f3-85 (1 100)) )
(test
   0
   (f3-85 (1 1 1)) )
(test
   0
   (f3-85) )

#3.86
(de f3-86 (L)
   (sum
      '((N) (and (< 10 N) N))
      L ) )
(test
   40
   (f3-86 '(20 1 1 1 20)) )

#3.87
(de f3-87 (L)
   (bool
      (find lst? L) ) )
(test
   T
   (f3-87 '(1 2 3 (4 5) 6)) )
(test
   NIL
   (f3-87 '(a b c)) )

#3.88
(de f3-88 (X)
   (let (R (frac 1 1)  X (frac X 1))
      (for I 4
         (setq R
            (f+ R (f/ (f** X I) (frac I 1))) ) )
      R ) )
(test
   (95653 . 12)
   (f3-88 13) )

#3.89
(de f3-89 (N L)
   (cnt
      '((I) (< N I))
      L ) )
(test
   4
   (f3-89 3 (1 2 3 4 5 6 7)) )

#3.90
(de f3-90 (L)
   (car (nth L 8)) )
(test
   8
   (f3-90 (range 1 10)) )

#3.91
(de f3-91 (L)
   (recur (L)
      (and
         (pair L)
         (+
            (if (< 1 (cnt sym? L)) 1 0)
            (cnt recurse L) ) ) ) )
(test
   3
   (f3-91 '((a a 1) a a (12 b c))) )
(test
   3
   (f3-91 '((a (2 b c 6) 7) d e ((9 f g) 12 (h 14) 15))) )

#3.92
(de f3-92 (L)
   (car (tail 2 L)) )
(test
   'B
   (f3-92 '(A B C)) )

#3.93
(de f3-93 (L)
   (bool
      (not
         (seek
            '((L) (member (car L) (cdr L)))
            L ) ) ) )
(test
   T
   (f3-93 (1 2 3)) )
(test
   NIL
   (f3-93 (1 2 2)) )

#3.94
(de f3-94 (L)
   (let M (apply min L)
      (cnt '((N) (= N M)) L) ) )
(test
   2
   (f3-94 (1 2 3 1)) )

#3.95
(de f3-95 (L)
   (cnt '((N) (bit? 1 N)) L) )
(test
   4
   (f3-95 (range 1 7)) )

#3.96
(de f3-96 (L)
   (let R NIL
      (mapc '((N) (accu 'R N 1)) L)
      (index (car (rassoc 1 R)) L) ) )
(test
   1
   (f3-96 (1 0 0 0)) )
(test
   4
   (f3-96 '(B B B A)) )

#3.97
(de f3-97 (L)
   (sum
      '((N) (and (bit? 1 N) N))
      L ) )
(test
   9
   (f3-97 (1 2 3 4 5)) )

#3.98
(de f3-98 (L)
   (or (apply >= L) (apply <= L)) )
(test
   T
   (f3-98 (3 2 2 1)) )
(test
   T
   (f3-98 (1 2 2 3)) )
(test
   NIL
   (f3-98 (10 2 2 3)) )

#3.99
(de f3-99 (L)
   (cnt lt0 L) )
(test
   3
   (f3-99 (-3 -2 -1 0)) )

#3.100
(de f3-100 (L)
   (for ((X . I) L (cdr I) (cdr I))
      (NIL (< (car I) (cadr I)) (inc X))
      T ) )
(test
   T
   (f3-100 (1 2 3 4 5)) )
(test
   4
   (f3-100 (1 2 3 1 5)) )

#3.101
(de f3-101 (L N)
   (= (cnt atom L) N) )
(test
   T
   (f3-101 (1 2 3) 3) )
(test
   NIL
   (f3-101 (1 2) 3) )
(test
   T
   (f3-101 (1 2 NIL) 3) )
(test
   NIL
   (f3-101 '(1 2 (a)) 3) )

#3.102
(de f3-102 (L)
   (let R (need 3 0)
      (mapc
         '((N)
            (cond
               ((bit? 1 N) (inc R))
               ((and (lt0 N) (not (bit? 1 N)))
                  (inc (cdr R)) )
               (T (inc (cddr R))) ) )
         L ) 
      R ) )
(test
   (8 3 2)
   (f3-102 '(11 -63 51 -32 -6 44 -59 55 -67 -24 0 -85 29)) )

#3.103
(de f3-103 (L)
   (let C 0
      (for (I L (cddr I) (cdr I))
         (or
            (= (car I) (cadr I))
            (= (cadr I) (caddr I))
            (= (car I) (caddr I))
            (inc 'C) ) )
      C ) )
(test
   4
   (f3-103 '(1 1 3 5 4 5 2 3 2 2 1 1 1)) )

#3.104
(de f3-104 (N)
   (let N (chop N)
      (= N (reverse N)) ) )
(test
   T
   (f3-104 6116) )
(test
   NIL
   (f3-104 6117) )

#3.105
(de f3-105 (L)
   (= (car L) (cadr L)) )
(test
   T
   (f3-105 '(a a b)) )
(test
   NIL
   (f3-105 '(a b b)) )

#3.106
(de f3-106 (L)
   (bool (=0 (car L))) )
(test
   NIL
   (f3-106 (1 2 3)) )
(test
   T
   (f3-106 (0 1 2 3)) )

#3.107
(de f3-107 (L)
   (apply + (fish atom L)) )
(test
   26
   (f3-107 '(1 2 3 (3 6) 2 1 (2 4) 2)) )

#3.108
(de f3-108 (L)
   (sum num? L) )
(test
   15
   (f3-108 '(1 2 NIL 3 4 5)) )

#3.109
(de reduce ("Fun" "Lst")
   (let "A" (car "Lst")
      (for "N" (cdr "Lst")
         (setq "A" ("Fun" "A" "N")) )
      "A" ) )
(de f3-109 (L)
   (reduce lcm L) )
(test
   232792560
   (f3-109 (range 20 11)) )

#3.110
(de f3-110 (X L)
   (find
      '((N) (and (not (bit? 1 N)) (< X N)))
      (fish atom L) ) )
(test
   4
   (f3-110 2 '(1 ((2 (3 4)) 5) 6)) )

#3.111
(de f3-111 (L)
   (fully num? L) )
(test
   NIL
   (f3-111 '(a 1)) )
(test
   T
   (f3-111 (1 1)) )

#3.112
(de f3-112 (L)
   (apply * L) )
(test
   3450
   (f3-112 (10 15 23)) )

#3.113
(de f3-113 (L)
   (maxi caddr L)
   @@ )
(let L
   (quote
      (aspirin 2 10 6)
      (analgin 3 20 1) )
   (test
      20
      (f3-113 L) ) )

#3.114
(de f3-114 (L)
   (mini caddr L)
   @@ )
(let L
   (quote
      (aspirin 2 10 6)
      (analgin 3 20 1) )
   (test
      10
      (f3-114 L) ) )

#3.115
(de f3-115 (L)
   (length L) )
(let L
   (quote
      (aspirin 2 10 6)
      (analgin 3 20 1) )
   (test
      2
      (f3-115 L) ) )

#3.116 (L)
(de f3-116 (L)
   (sum caddr L) )
(let L
   (quote
      (aspirin 2 10 6)
      (analgin 3 20 1) )
   (test
      30
      (f3-116 L) ) )

#3.117
(de f3-117 (L)
   (+ (car L) (last L)) )
(test
   5
   (f3-117 (1 2 3 4)) )

#3.118
(de f3-118 (L)
   (format (maxi format (permute L))) )
(test
   9534330
   (f3-118 (3 30 34 5 9)) )

#3.119
(de f3-119 (L)
   (ifn (cdr L)
      0
      (apply
         max
         (make
            (for (I L (cdr I) (cdr I))
               (link (- (car I) (cadr I))) ) ) ) ) )
(test
   4
   (f3-119 (7 5 1 3)) )
(test
   4
   (f3-119 (7 3 1)) )
(test
   0
   (f3-119 (100)) )

#3.120
(de f3-120 (L)
   (cnt sym? L) )
(test
   5
   (f3-120 '(2 s 3 f 7 f a v)) )

#3.121
(de 50% (N)
   (/
      (inc N (if (bit? 1 N) 1 0))
      2 ) )
(de f3-121 (L)
   (let (P (50% (length L))  R NIL)
      (mapc
         '((N) (accu 'R N 1))
         L )
      (and
         (find '((L) (<= P (cdr L))) R)
         (car @) ) ) )
(test
   3
   (f3-121 '(1 2 3 3 3 1 3 3 2)) )
(test
   NIL
   (f3-121 '(1 2 3 3 3 1 3 3 2 2 2 2)) )
(test
   2
   (f3-121 '(1 2 3 3 3 1 3 3 2 2 2 2 2 2 2)) )

#3.122
(de f3-122 (L)
   (if (cdr L) (f3-122 (cdr L)) (car L)) )
(test
   3
   (f3-122 (1 2 3)) )

#3.123
(de f3-123 (L)
   (sum num? (fish atom L)) )
(test
   36
   (f3-123 '(1 2 (((3))) (4 a ((b)) 5 (((6 7)))) 8)) )
   
#3.124
(de f3-124 (L)
   (sum
      '((N) 
         (and (num? N) (not (bit? 1 N)) N) )
      (fish atom L) ) )
(test
   20
   (f3-124 '(1 2 (((3))) (4 a ((b)) 5 (((6 7)))) 8)) )

#3.125
(de f3-125 (L)
   (reduce gcd L) )
(test
   1
   (f3-125 (9 27 81 1000)) )
(test
   9
   (f3-125 (9 27 81 1008)) )

#3.126
(de f3-126 (L)
   (apply min L) )
(test
   0
   (f3-126 (1 2 3 0)) )

#3.127
(de f3-127 (L)
   (let M (dec (length L))
      (apply
         +
         (mapcan
            '((L X) (head X L)) 
            L
            (range 0 M) ) ) ) )
(test
   19
   (f3-127
      (quote
         (1 2 3)
         (4 5 6)
         (7 8 9) ) ) )
(test
   80
   (f3-127
      (quote
         (9 10 11 12)
         (8 21 31 41)
         (7 12 13 14)
         (6 23 24 25) ) ) )

