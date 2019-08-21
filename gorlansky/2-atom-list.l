#2.1
(de f2-1 (Lst)
   (let R NIL
      (mapc
         '((I)
            (accu 'R I 1) )
         Lst )
      R ) )
(test
   '((c . 2) (b . 2) (a . 3))
   (f2-1 '(a b a a c c b)) )

#2.2 - ignored

#2.3
(de balanced? (Lst)
   (let L (mapcar format Lst)
      (=
         (+ (car L) (cadr L))
         (+ (caddr L) (cadddr L)) ) ) )
(de f2-3 (N)
   (make
      (for I N
         (and
            (balanced? (chop (pad 4 I)))
            (link (pad 4 I)) ) ) ) )
(test
   '("0101" "0110" "0202" "0211" "0220")
   (f2-3 300) )

#2.4
(de f2-4 (N)
   (mapcar
      format
      (chop N) ) )
(test
   (1 2 3 4)
   (f2-4 1234) )

#2.5
(de f2-5-1 (N)
   (make (for I N (link (* I I)))) )
(de f2-5-2 (N)
   (mapcar
      '((I) (* I I))
      (range 1 N) ) )
(test
   (f2-5-1 10)
   (f2-5-2 10) )

#2.6
(de f2-6 (N)
   (let L
      (make
         (for (I N (gt0 I) (dec I))
            (link I) ) )
      (list (format (pack L)) L) ) )
(test
   (654321 (6 5 4 3 2 1))
   (f2-6 6) )

#2.7
(de f2-7 (N)
   (let L (& 1 N)
      (until (=0 (setq N (>> 1 N)))
         (push 'L (& 1 N)) )
      (pack L) ) )
(test
   "11011"
   (f2-7 27) )
(test
   "1010"
   (f2-7 10) )

#2.8
(de f2-8 (Lst)
   (let N 0
      (for I Lst
         (setq N (| I (>> -1 N))) )
      N ) )
(test
   27
   (f2-8 (1 1 0 1 1)) )

#2.9 - ignored

#2.10 - rosetta code
(de mersenne? (P)
   (or
      (= P 2)
      (let (MP (dec (>> (- P) 1))  S 4)
         (do (- P 2)
            (setq S (% (- (* S S) 2) MP)) )
         (=0 S) ) ) )
(de f2-10 (N)
   (make
      (for I N
         (and (prime? I) (mersenne? I) (link I)) ) ) )
(test
   (2 3 5 7 13 17 19 31 61 89)
   (f2-10 100) )

#2.11 - ignored

#2.12 - ignored

#2.13
(de f2-13 (N)
   (make
      (for I N
         (and
            (bit? 1 I)
            (link I) ) ) ) )
(test
   (1 3 5 7 9 11 13 15 17 19)
   (f2-13 20) )

#2.14 - ignored

#2.15
(de f2-15 (N)
   (let (Len (length (chop N))  Part (/ Len 2))
      ~(assert (not (bit? 1 Len)))
      (make
         (for (I 0 (>= N I) (inc I))
            (let L (mapcar format (chop (pad Len I)))
               (and
                  (=
                     (apply + (head Part L))
                     (apply + (tail Part L)) )
                  (link L) ) ) ) ) ) )
(test
   670
   (length (f2-15 9999)) )

#2.16
(test
   10935
   (length (f2-15 222222)) )

#2.17
(de f2-17 (N)
   (make
      (for I (dec N)
         (link (list I (- N I))) ) ) )
(test
   19
   (length (f2-17 20)) )

#2.18
(test
   24
   (length (f2-17 25)) )

#2.19
(de f2-19 (N M)
   (default M N)
   (if (=0 N)
      M
      (cons (f2-19 (dec N) M)) ) )
(test
   '(((((((7)))))))
   (f2-19 7) )

#2.20
(de f2-20 (N)
   (make
      (for I N
         (link (apply * (range 1 I))) ) ) )
(test
   (1 2 6 24 120)
   (f2-20 5) )

#2.21
(de dice ()
   (let (X (rand 1 6)  Y (rand 1 6))
      (cons (+ X Y) (cons X Y)) ) )
(de move ()
   (let (R (list 0 NIL)  D NIL)
      (loop
         (setq D (dice))
         (inc R (car D))
         (push (cdr R) (cdr D))
         (T
            (or
               (= 7 (car D))
               (= 11 (car D)) )
            (set R T) )
         (NIL
            (or
               (= 2 (car D))
               (= 12 (car D)) ) ) )
      R ) )
# T - first wins
# NIL - second wins
# 0 - draw
(de f2-21 ()
   (let (X (move)  Y (move))
      (println 'first X)
      (println 'second Y)
      (cond
         ((or
            (=T (car X))
            (> (car X) (car Y)) ) @ )
         ((= (car X) (car Y)) 0) ) ) )
#(println (f2-21)) # uncomment if want to play

#2.22
(de f2-22 (N)
   (make
      (do N
         (link (rand 1 100)) ) ) )
## (f2-22 10) # uncomment if randomness

#2.23 - ignored

#2.24
(de f2-24 (N F)
   (make
      (for I (/ N 2)
         (and (=0 (% N I)) (F I)) ) ) )
(test
   (f2-24 99 link)
   (flip (f2-24 99 yoke)) )

#2.25
(de f2-25 (Str)
   (make
      (map
         '((L)
            (link (pack L)) )
         (cdr (chop Str)) ) ) )
(test
   '("bc" "c")
   (f2-25 "abc") )
(test
   '("ike" "ke" "e")
   (f2-25 "Mike") )

#2.26
(de f2-26 (N)
   (bin (format N)) )
(test
   10
   (f2-26 1010) )

#2.27
(de f2-27 (N)
   (conc (cons '*) (range 1 N)) )
(test
   '(* 1 2 3 4 5 6 7 8 9 10)
   (f2-27 10) )
(test
   3628800
   (eval (f2-27 10)) )

#2.28 - ignored

#2.29
(de accud (Var Key)
   (if (assoc Key (val Var))
      (con @ (inc (cdr @)))
      (push Var (cons Key 1)) )
   Key )
(de factor-sum (N)
   (if (=1 N)
      0
      (let
         (R NIL
            D 2
            L (1 2 2 . (4 2 4 2 4 6 2 6 .))
            M (sqrt N)
            N1 N
            S 1 )
         (while (>= M D)
            (if (=0 (% N1 D))
               (setq M
                  (sqrt (setq N1 (/ N1 (accud 'R D)))) )
               (inc 'D (pop 'L)) ) )
         (accud 'R N1)
         (for I R
            (one D)
            (one M)
            (for J (cdr I)
               (setq M (* M (car I)))
               (inc 'D M) )
               (setq S (* S D)) )
         (- S N) ) ) )
(de f2-29 (N)
   (make
      (for I N
         (let X (factor-sum I)
            (and
               (> X I)
               (= I (factor-sum X))
               (link (cons I X)) ) ) ) ) )
(test
   '((220 . 284) (1184 . 1210) (2620 . 2924)
      (5020 . 5564) (6232 . 6368) (10744 . 10856)
      (12285 . 14595) (17296 . 18416) )
   (f2-29 20000) )

#2.30
(de f2-30 (N)
   (list
      (* N N)
      (* N N N)
      (* N N N N) ) )
(test
   (4 8 16)
   (f2-30 2) )

#2.31
(de f2-31 (Str)
   (let (C NIL  D NIL)
      (for I (chop Str)
         (if (format I)
            (push 'D @)
            (push 'C I) ) )
      (list D C) ) )
(test
   '((4 3 2 1) ("c" "b" "a"))
   (f2-31 "a1b23c4") )

#2.32
(de f2-32 (Lst)
   (let R NIL
      (mapc
         '((I)
            (accu 'R I 1) )
         Lst )
      (mapcan
         '((I)
            (and
               (< 1 (cdr I))
               (cons (car I)) ) )
         R ) ) )
(test
   '(c b)
   (f2-32 '(a b b c c c)) )
(test
   NIL
   (f2-32 '(a b c)) )

#2.33
(de f2-33 (Str)
   (let (Lst (str Str)  U (uniq (chop (car Lst))) )
      (filter
         '((I)
            (fully '((I) (member I U)) (chop I)) )
         Lst ) ) )
(test
   '(aab aba)
   (f2-33 "aab abc aba") )

#2.34
(de f2-34 (Str)
   (mapcar
      length
      (str Str) ) )
(test
   (1 2 3)
   (f2-34 "a aa aaa") )

#2.35 - ignored

#2.36
(de f2-36-1 (N) # rosetta code too
   (make
      (let (D 2  L (1 2 2 . (4 2 4 2 4 6 2 6 .))  M (sqrt N))
         (while (>= M D)
            (if (=0 (% N D))
               (setq M (sqrt (setq N (/ N (link D)))))
               (inc 'D (pop 'L)) ) )
         (link N) ) ) )
(de f2-36-2 (N)
   (make
      (for (I 2 (>= N I) (inc I))
         (and
            (=0 (% N I))
            (prime? I)
            (link I) ) ) ) )
(test
   (f2-36-1 1011234)
   (f2-36-2 1011234) )

#2.37
(de oddc? (S)
   (cache '(NIL) S (bit? 1 (format S))) )
(de oddn? (N)
   (fully oddc? (chop N)) )
(de flipN (N)
   (format (flip (chop N))) )
(de f2-37 (N)
   (make
      (for I N
         (and
            (gt0 (% I 10))
            (oddn? (+ I (flipN I)))
            (link I) ) ) ) )
(test
   (12 14 16 18 21 23 25)
   (f2-37 25) )

#2.38 - ignored

#2.39
(de f2-39 (A)
   (mapcar
      '((I)
         (if (format I)
            @
            (intern I) ) )
   (chop A) ) )
(test
   '(a b c 1 2)
   (f2-39 'abc12) )

#2.40
(de f2-40 (X N M)
   (default N 0  M 1)
   (if (>= M X)
      NIL
      (cons M (f2-40 X M (+ N M))) ) )
(test
   (1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987)
   (f2-40 1000) )

