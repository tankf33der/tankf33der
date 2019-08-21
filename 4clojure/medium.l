#46 Flipping out
(de f46 (X)
   (curry (X) (A B) (X B A)) )
(test
   3
   (cadr ((f46 nth) 2 (1 2 3 4 5))) )
(test
   T
   ((f46 >) 7 8) )
(test
   (1 2 3)
   ((f46 head) (1 2 3 4 5) 3) )

#44 Rotate Sequence
(de modulo (X Y)
   (% (+ Y (% X Y)) Y) )
(de f44 (N L)
   (let (Len (length L)  S (modulo N Len))
      (append (tail (- Len S) L) (head S L)) ) )
(test
   (3 4 5 1 2)
   (f44 2 (1 2 3 4 5)) )
(test
   (4 5 1 2 3)
   (f44 -2 (1 2 3 4 5)) )
(test
   (2 3 4 5 1)
   (f44 6 (1 2 3 4 5)) )
(test
   '(b c a)
   (f44 1 '(a b c)) )
(test
   '(c a b)
   (f44 -4 '(a b c)) )

#43 Reverse Interleave
(de f43 (L N)
   (let R (need N)
      (while L
         (map
            '((I) (queue I (pop 'L)))
            R ) )
      R ) )
(test
   '((1 3 5) (2 4 6))
   (f43 (1 2 3 4 5 6) 2) )
(test
   '((0 3 6) (1 4 7) (2 5 8))
   (f43 (range 0 8) 3) )
(test
   '((0 5) (1 6) (2 7) (3 8) (4 9))
   (f43 (range 0 9) 5) )

#50 Split by Type
(de f50 (L)
   (by
      '((X) (if (num? X) 0 (sym? X)))
      group
      L ) )
(test
   '((1 2 3) (a b c))
   (f50 '(1 a 2 b 3 c)) )
(test
   '(((1 2) (3 4)) (a b) (5 6))
   (f50 '((1 2) a (3 4) 5 6 b)) )

#55 Count Occurrences
(de f55 (L)
   (let A NIL
      (for X L
         (accu 'A X 1) )
      A ) )
(test
   '((3 . 1) (2 . 2) (1 . 4))
   (f55 (1 1 2 3 2 1 1)) )
(test
   '((a . 2) (b . 3))
   (f55 '(b a b a b)) )
(test
   '(((1 3) . 2) ((1 2) . 1))
   (f55 '((1 2) (1 3) (1 3))) )

#56 Find Distinct Items
(de f56 (L)
   (make
      (for X L
         (unless (member X (made))
            (link X) ) ) ) )
(test
   '(1 2 3 4)
   (f56 (1 2 1 3 1 2 4)) )
(test
   '(a b c)
   (f56 '(a a b b c c)) )
(test
   (range 1 50)
   (f56 (range 1 50)) )

#58 Function Composition
(de f58 Args 
   (list 
      '@
      (recur (Args) 
         (ifn (cdr Args) 
            (list 'pass (car Args)) 
            (list (car Args) (recurse (cdr Args))) ) ) ) )
(test
   (3 2 1)
   ((f58 cdr reverse) (1 2 3 4)) )
(test
   0
   ((f58 =0 '((X) (% X 8)) +) 3 5 7 9) )

#59 Juxtaposition
(de f59 Args
   (list
      '@
      (list 'mapcar 'pass (lit Args)) ) )
(test
   '(21 6 1)
   ((f59 + max min) 2 3 5 1 6 4) )
(test
   '("HELLO" 5)
   ((f59 uppc length) "hello") )
(test
   '(a (b c))
   ((f59 car cdr) '(a b c)) )

#54 Partition a Sequence
(de f54 (N L)
   (make
      (do (/ (length L) N)
         (link (cut N 'L)) ) ) )
(test
   '((0 1 2) (3 4 5) (6 7 8))
   (f54 3 (range 0 8)) )
(test
   '((0 1) (2 3) (4 5) (6 7))
   (f54 2 (range 0 7)) )
(test
   '((0 1 2) (3 4 5))
   (f54 3 (range 0 7)) )

#70 Word Sorting
(de f70 (S)
   (mapcar
      pack
      (by
         '((L)
            (mapcar '((I) (char (lowc I))) L) )
         sort
         (split 
            (filter
               '((I) (not (member I '("." "!"))))
               (chop S) )
            " " ) ) ) )
(test
   '("a" "day" "Have" "nice")
   (f70 "Have a nice day.") )
(test
   '("a" "is" "language" "PicoLisp")
   (f70 "PicoLisp is a language!") )
(test
   '("fall" "follies" "foolish" "Fools" "for")
   (f70 "Fools fall for foolish follies.") )

#67 Prime Numbers
(de prime? (N)
   (or
      (= N 2)
      (and
         (> N 1)
         (bit? 1 N)
         (let X (sqrt N)
            (for (D 3  T  (+ D 2))
               (T (> D X) T)
               (T (=0 (% N D)) NIL) ) ) ) ) ) 
(de f67 (N)
   (let X 1
      (make
         (while (gt0 N)
            (when (prime? (inc 'X))
               (link X)
               (dec 'N) ) ) ) ) )
(test
   (2 3)
   (f67 2) )
(test
   (2 3 5 7 11)
   (f67 5) )
(test
   541
   (last (f67 100)) )

#74 Filter Perfect Squares
(de f74 (S)
   (filter
      '((N)
         (let X (sqrt N)
            (= (* X X) N) ) )
      (mapcar
         format
         (split
            (chop S)
            "," ) ) ) )
(test
   (4 9)
   (f74 "4,5,6,7,8,9") )
(test
   (16 25 36)
   (f74 "15,16,25,36,37") )

#76 Intro to Trampoline
### simplest function and implementation
(de f76 (N)
   (if (gt0 N)
      (list 'f76 (lit (dec N)))
      'done ) )
(de trampoline (F N)
   (let R (F N)
      (while (fun? (setq R (eval R))))
      R ) )
(test
   'done
   (trampoline 'f76 10) )

#80 Perfect Numbers
(de f80 (N)
   (=
      N
      (apply
         +
         (filter
            '((D) (=0 (% N D)))
            (range 1 (dec N)) ) ) ) )
(test
   T
   (f80 6) )
(test
   NIL
   (f80 7) )
(test
   T
   (f80 496) )
(test
   NIL
   (f80 500) )
(test
   T
   (f80 8128) )

#77 Anagram Finder
(de f77 (L)
   (filter
      cdr
      (by '((S) (sort (chop S))) group L) ) )
(test
   '(("meat" "team" "mate"))
   (f77  '("meat" "mat" "team" "mate" "eat")) )
(test
   '(("veer" "ever") ("lake" "kale") ("item" "mite"))
   (f77 '("veer" "lake" "item" "kale" "mite" "ever")) )

#60 Sequence Reductions
(de f60 ("Fun" "Lst")
   (make
      (let "A" (car "Lst")
         (link "A")
         (for "N" (cdr "Lst")
            (link (setq "A" ("Fun" "A" "N"))) ) ) ) )

# reduce from elementary.l (task #64)
(test
   (1 2 3 4)
   (f60 + (1 1 1 1)) )
(test
   (reduce * (2 3 4 5))
   (last (f60 * (2 3 4 5))) )

#69 Merge with a Function
(de f69 (F . @)
   (let (R NIL  Y)
      (while (args)
         (for X (next)
            (nond
               ((assoc (car X) R)
                  (queue 'R (list (car X) (cdr X))) )
               ((cdr (setq Y (cdr @))) 
                  (conc Y (list (cdr X))) )
               (NIL (set @ (cdr X))) ) ) ) 
      (for X R
         (con X
            (if (cddr X)
               (apply F (cdr X))
               (cadr X) ) ) )
      R ) )
(test
   '((a . 4) (b . 6) (c . 20))
   (f69 
      * 
      '((a . 2) (b . 3) (c . 4)) 
      '((a . 2)) '((b . 2)) '((c . 5)) ) )
(test
   '((1 . 7) (2 . 10) (3 . 15))
   (f69
      -
      '((1 . 10) (2 . 20))
      '((1 . 3) (2 . 10) (3 . 15)) ) )
(test
   '((a 3 4 5) (b 6 7) (c 8 9))
   (f69
      append
      '((a 3) (b 6))
      '((a 4 5) (c 8 9) (b 7)) ) )

#102 intoCamelCase
(de f102 (S)
   (let S (split (chop S) '-)
      (for I (cdr S)
         (set I (uppc (val I))) )
      (pack S) ) )
(test
   "something"
   (f102 "something") )
(test
   "multiWordKey"
   (f102 "multi-word-key") )
(test
   "leaveMeAlone"
   (f102 "leaveMeAlone") )

#75 Euler's Totient Function
# (gcd) from task #100 (easy.l)
(de f75 (N)
   (cnt
      '((R)
         (= 1 (gcd R N)) )
      (range 1 N) ) )
(test
   1
   (f75 1) )
(test
   4
   (f75 10) )
(test
   16
   (f75 40) )
(test
   60
   (f75 99) )

#86 Happy numbers
(de f86 (N)
   (let Seen NIL
      (loop
         (T (= N 1) T)
         (T (member N Seen))
         (setq N
            (sum '((C) (** (format C) 2))
               (chop (push 'Seen N)) ) ) ) ) )
(test
   T
   (f86 7) )
(test
   T
   (f86 986543210) )
(test
   NIL
   (f86 2) )
(test
   NIL
   (f86 3) )

#78 Reimplement Trampoline
# already implemented in task #76

#85 Power set
(de f85 (Lst)
   (ifn Lst
      (cons)
      (let L (f85 (cdr Lst))
         (conc
            (mapcar '((X) (cons (car Lst) X)) L)
            L ) ) ) )
(test
   '((1 a) (1) (a) NIL)
   (f85 '(1 a)) )
(test
   '(NIL)
   (f85 '()) )
(test
   '((1 2 3) (1 2) (1 3) (1) (2 3) (2) (3) NIL)
   (f85 (1 2 3)) )
(test
   1024
   (length (f85 (range 1 10))) )

#115 The Balance of N
(de f115 (N)
   (let (N (chop N)  H (/ (length N) 2))
      (=
         (apply + (mapcar format (head H N)))
         (apply + (mapcar format (tail H N))) ) ) )
(test
   T
   (f115 11) )
(test
   T
   (f115 121) )
(test
   NIL
   (f115 123) )
(test
   T
   (f115 0) )
(test
   NIL
   (f115 88099) )
(test
   T
   (f115 89098) )
(test
   T
   (f115 89089) )

#98 Equivalence Classes
(de f98 (F L)
   (by F group L) )
(test
   '((-2 2) (-1 1) (0))
   (f98 '((X) (* X X)) (-2 -1 0 1 2)) )
(test
   '((0 3) (1 4) (2 5))
   (f98 '((X) (% X 3)) (0 1 2 3 4 5)) )
(test
   '((0) (1) (2) (3) (4) (5))
   (f98 lit (0 1 2 3 4 5)) )
(test
   '((0 1 2 3 4 5))
   (f98 t (0 1 2 3 4 5)) )

#105 Identify keys and values
(de f105 (L)
   (let R NIL
      (for I L
         (if (sym? I)
            (push 'R (cons I))
            (conc (car R) (cons I)) ) )
      (flip R) ) )
(test
   NIL
   (f105 NIL) )
(test
   '((a 1))
   (f105 '(a 1)) )
(test
   '((a 1) (b 2))
   (f105 '(a 1 b 2)) )
(test
   '((a 1 2 3) (b) (c 4))
   (f105 '(a 1 2 3 b c 4)) )

#137 Digits and bases
(de f137 (N B)
   (make
      (while 
         (and
            (gt0 N)
            (yoke (% N B))
            (setq N (/ N B)) ) ) ) )
(test
   (1 2 3 4 5 0 1)
   (f137 1234501 10) )
(test
   NIL
   (f137 0 11) )
(test
   (1 0 0 1)
   (f137 9 2) )
(use R
   (seed (time))
   (setq R (rand 1 100000))
   (test
      (1 0)
      (f137 R R) ) )
(test
   (16 18 5 24 15 1)
   (f137 2147483647 42) )

#110 Sequence of pronunciations
# (take) and (iterate) from #45 easy.l
(de f110 (L)
   (let (N 0  X (car L))
      (make
         (for I L
            (if (= X I)
               (inc 'N)
               (link N X)
               (one N)
               (setq X I)) )
         (link N X) ) ) )
(test
   '((1) (1 1) (2 1) (1 2 1 1))
   (take 4 `(iterate f110 (1))) )
(test
   (3 1 2 4)
   (f110 (1 1 1 4 4)) )
(test
   (1 1 1 3 2 1 3 2 1 1)
   (last (take 8 `(iterate f110 (1)))) )
(test
   338
   (length
      (last 
         (take 17 `(iterate f110 (3 2))) ) ) )

#144 Oscilrate
(de cterate Args
   (let ("X" (car Args)  "F" (apply circ (cdr Args)))
      (list 
         'job
         (lit (env '("X" "F")))
         '(prog1 "X" (setq "X" ((pop '"F") "X"))) ) ) )
(test
   (3 0 5 2 7)
   (take 5 `(cterate 3 ((N) (- N 3)) ((N) (+ 5 N)))) )
(test
   (0 1 0 1 0 1 2 1 2 1 2 3)
   (take 12 `(cterate 0 inc dec inc dec inc)) )

#108 Lazy Searching
(de f108 @
   (let L (mapcar cons (rest))
      (until (apply = (mapcar caar L))
         (pop (mini caar L)) )
      (caaar L) ) )
(test
   12
   (f108 (1 2 3 4 5 12 18) (-1 5 10 12) (3 12 17)) )
(test
   4
   (f108 (1 2 3 4 5 6 7) (4 19 25 67 149) (1 3 4 19) (4 17)) )
(test
   1
   (f108 (1 2 3)) )

#93 Partially Flatten a Sequence
(de f93 (L)
   (cond
      ((not L))
      ((atom (car L)) (cons L))
      (T 
         (conc
            (f93 (car L))
            (f93 (cdr L)) ) ) ) )
(test
   '((do) (Nothing))
   (f93 '((do) (Nothing))) )
(test
   '((a b) (c d) (e f))
   (f93 '((((a b))) ((c d)) (e f))) )
(test
   '((1 2) (3 4) (5 6))
   (f93 '((1 2)((3 4)((((5 6))))))) )

#114 Global take-while
(de f114 (N F L)
   (make
      (for I L
         (T (and (F I) (=0 (dec 'N))))
         (link I) ) ) )
(test
   (2 3 5 7 11 13)
   (f114 
      4 
      '((Y) (= 2 (% Y 3))) 
      (2 3 5 7 11 13 17 19 23)) )

#132 Insert between two items
(de f132 (Fun Val Lst)
   (mapcon
      '((L)
         (cons
            (car L)
            (when (Fun (car L) (cadr L)) (cons Val)) ) )
      Lst ) )
(test
   '(1 less 2 less 3)
   (f132 '< 'less (1 2 3)) )
(test
   '(0 1 x 2 x 3 x 4)
   (f132 '((X Y) (and (gt0 X) (< X Y))) 'x (range 0 4)) )

#104 Write Roman Numerals
(de roman (N)
   (pack
      (make
         (mapc
            '((C D)
               (while (>= N D)
                  (dec 'N D)
                  (link C) ) )
            '(M CM D CD C XC L XL X IX V IV I)
            (1000 900 500 400 100 90 50 40 10 9 5 4 1) ) ) ) )
(test
   "I"
   (roman 1) )
(test
   "XXX"
   (roman 30) )
(test
   "DCCCXXVII"
   (roman 827) )
(test
   "XLVIII"
   (roman 48) )

#103 Generating k-combinations
(de comb (M Lst)
   (cond
      ((=0 M) '(NIL))
      ((not Lst))
      (T
         (conc
            (mapcar
               '((Y) (cons (car Lst) Y))
               (comb (dec M) (cdr Lst)) )
            (comb M (cdr Lst)) ) ) ) )
(test
   '((4) (5) (6))
   (comb 1 (4 5 6)) )
(test
   '((0 1) (0 2) (1 2))
   (comb 2 (0 1 2)) )
(test
   '((0 1 2) (0 1 3) (0 1 4) (0 2 3) (0 2 4) 
      (0 3 4) (1 2 3) (1 2 4) (1 3 4) (2 3 4))
   (comb 3 (0 1 2 3 4)) )

#116 Prime Sandwich
# (prime?) from task #67 (medium.l)
(de genprime (N)
   (let X N
      (until (prime? (dec 'N)))
      (until (prime? (inc 'X))) 
      (cons N X) ) )
(de f116 (N)
   (let L (genprime N)
      (and
         (prime? N)
         (= (- N (car L)) (- (cdr L) N)) ) ) )
(test
   NIL
   (f116 4) )
(test
   T
   (f116 563) )
(test
   T
   (f116 1103) )

#121 Universal Computation Engine
(de f121 (M)
   (curry (M) (E) (bind M (eval E))) )
(test
   2
   ((f121 '((B . 8) (A . 16))) '(/ A B)) )
(test
   (6 0 -4)
   (mapcar
      '((M) ((f121 M) '(* (+ 2 A) (- 10 B))))
      (quote
         ((A . 1) (B . 8))
         ((B . 5) (A . -2))
         ((A . 2) (B . 11)) ) ) )

#148 The Big Divide
(de f148 (N A B)
   (let
      (E '((X) (/ (dec N) X))
         F 
         '((X) 
            (* 
               X 
               (*/ (E X) (inc (E X)) 2) ) ) )
      (-
         (+ (F A) (F B))
         (F (* A B)) ) ) )
(test
   0
   (f148 3 17 11) )
(test
   23
   (f148 10 3 5) )
(test
   233168
   (f148 1000 3 5) )
(test
   2333333316666668
   (f148 100000000 3 5) )
(test
   110389610389889610389610
   (f148 (* 10000 10000 10000) 7 11) )
(test
   1277732511922987429116
   (f148 (* 10000 10000 10000) 757 809) )
(test
   4530161696788274281
   (f148 (* 10000 10000 1000) 1597 3571) )

#171 Intervals
(de f171 (Lst)
   (let (R NIL  Lst (sort Lst)  Last NIL)
      (for I Lst
         (case (- I Last) 
            (NIL (push 'R (cons I)))
            ((0 1))
            (T (conc (car R) (cons Last)) 
               (push 'R (cons I)) ) )
         (setq Last I) )
      (conc (car R) (cons Last))
      (flip R) ) )
(test
   '((1 3))
   (f171 (1 2 3)) )
(test
   '((1 3) (8 10))
   (f171 (10 9 8 1 2 3)) )
(test
   '((1 1))
   (f171 (1 1 1 1 1 1 1)) )
(test
   NIL
   (f171 NIL) )
(test
   '((1 4) (6 6) (9 11) (13 17) (19 19))
   (f171 (19 4 17 1 3 10 2 13 13 2 16 4 2 15 13 9 6 14 2 11)) )

#131 Sum Some Set Subsets
# (subsets) from simul.l
(de f131 Sets
   (let Sums
      (setq Sums
         (mapcar
            '((L)
               (uniq
                 (mapcar
                     '((I) (apply + I))
                     (make
                        (for N (length L)
                           (chain (subsets N L)) ) ) ) ) )
            Sets ) )
      (pick
         '((I)
            (fully '((L) (member I L)) (cdr Sums)) ) 
         (car Sums) ) ) )
(test
   T
   (f131 (-1 1 99) (-2 2 888) (-3 3 7777)) )
(test
   NIL
   (f131 (1) (2) (3) (4)) )
(test
   T
   (f131 (1)) )
(test
   NIL
   (f131 (1 -3 51 9) (0) (9 2 81 33)) )
(test
   T
   (f131 (1 3 5) (9 11 4) (-3 12 3) (-3 4 -2 10)) )
(test
   NIL
   (f131 (-1 -2 -3 -4 -5 -6) (1 2 3 4 5 6 7 8 9)) )
(test
   T
   (f131 (1 3 5 7) (2 4 6 8)) )
(test
   T
   (f131 (-1 3 -5 7 -9 11 -13 15) (1 -3 5 -7 9 -11 13 -15)
      (1 -1 2 -2 4 -4 8 -8) ) )
(test
   T
   (f131 (-10 9 -8 7 -6 5 -4 3 -2 1) (10 -9 8 -7 6 -5 4 -3 2 -1)) )
    
#112 Sequs Horribilis
(de f112 (Sum X)
   (recur (X)
      (if (atom X)
         (and (ge0 (dec 'Sum X)) X)
         (let? Y (recurse (car X))
            (cons Y (recurse (cdr X))) ) ) ) )
(test (1 2 (3 (4)))
   (f112 10 (1 2 (3 (4 5) 6) 7)) )
(test (1 2 (3 (4 (5 (6 (7))))))
   (f112 30 (1 2 (3 (4 (5 (6 (7 8)) 9)) 10) 11)) )
(test (0 1 2 3)
   (f112 9 (range 0 4)) )
(test '(((((1)))))
   (f112 1 '(((((1)))))) )
(test ()
   (f112 0 (1 2 (3 (4 5) 6) 7)) )
(test (0 0 (0 (0)))
   (f112 0 (0 0 (0 (0)))) )
(test (-10 (1 (2 3 (4))))
   (f112 1 (-10 (1 (2 3 (4 5 (6 7 (8))))))) )

#141 Tricky card games
# representation from #128 (easy.l)
(de f141 (L S)
   (default S (caar L))
   (maxi
      cdr
      (filter
         '((I)
            (= (car I) S) )
         L ) ) )
(test
   T
   (and
      (= '(club . 9) (f141 '((club . 4) (club . 9))) )
      (= '(spade . 2) (f141 '((spade  . 2) (club . 10)))) ) )
(test
   '(club . 10)
   (f141 '((spade . 2) (club . 10)) 'club) )
(test
   '(heart . 8)
   (f141 '((heart . 6) (heart . 8) (diamond . 10)
      (heart . 4) ) 'heart ) )

#177 Balancing Brackets
# square 0; round T; curly NIL;
(de f177 (S)
   (let R NIL
      (for S (chop S)
         (T
            (case S
               ("[" (push 'R 0) NIL)
               ("(" (push 'R T) NIL)
               ("{" (push 'R NIL) NIL)
               ("]" (n0 (pop 'R)))
               (")" (nT (pop 'R)))
               ("}" (pop 'R)) ) )
         (not R) ) ) )
(test
   T
   (f177 "This string has no brackets.") )
(test
   T
   (f177 "class Test {
      public static void main(String[] args) {
        System.out.println(\"Hello world.\");
      }
    }") )
(test
   NIL
   (f177 "(start, end]") )
(test
   NIL
   (f177 "())") )
(test
   NIL
   (f177 "[ { ] } ") )
(test
   T
   (f177 "([]([(()){()}(()(()))(([[]]({}()))())]((((()()))))))") )
(test
   NIL
   (f177 "([]([(()){()}(()(()))(([[]]({}([)))())]((((()()))))))") )
(test
   NIL
   (f177 "[") )

#150 Palindromic Numbers
(de f150 (N Cnt)
   (make
      (do Cnt
         (while (let L (chop N) (<> L (reverse L)))
            (inc 'N) )
         (link N)
         (inc 'N) ) ) )
(test
   (0 1 2 3 4 5 6 7 8 9 11 22 33 44 55 66 77 88 99
      101 111 121 131 141 151 161)
   (f150 0 26) )
(test
   (1234554321 1234664321 1234774321
      1234884321 1234994321 1235005321)
   (f150 1234550000 6) )

#168 Infinite Matrix
# XXX Ignore now
(de f168 (Fun M N Rows Cols)
   (nond
      (M Fun)  
      (Rows
        (curry (Fun M N) (I J)
          (Fun (+ M I) (+ N J)) ) )
      (NIL
         (mapcar
            '((Row)
               (mapcar
                  '((Col) (Fun (+ M Row -1) (+ N Col -1)))
                  (range 1 Cols) ) )
            (range 1 Rows) ) ) ) )

#195 Parentheses... Again
(de f195 (Pairs)
   (let (Open 0  Close 0  Output)
      (make
         (recur (Output Open Close)
            (if (= Close Pairs)
               (link Output)
               (when (> Pairs Open)
                  (recurse (pack Output "(") (inc Open) Close) )
               (when (> Open Close)
                  (recurse (pack Output ")") Open (inc Close)) ) ) ) ) ) )
(test
   '("((()))" "(()())" "(())()" "()(())" "()()()")
   (f195 3) )
(test
   16796
   (length (f195 10)) )

