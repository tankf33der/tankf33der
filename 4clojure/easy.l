#19 Last Element
(de f19 (L) 
   (while (cdr L)
      (pop 'L) )
   (car L) )
(test
   3
   (f19 (1 2 3)) )

#20 Penultimate Element
(de f20 (L)
   (when (cdr L)
      (while (cddr L)
         (pop 'L) )
      (car L) ) )
(test
   2
   (f20 (1 2 3)) )

#21 Nth Element
(de f21 (L N) #zero based
   (do (inc N) (pop 'L)) )
(test
   NIL
   (f21 (1 2 3) -1) )
(test
   2
   (f21 (1 2 3) 1) )
(test
   NIL
   (f21 (1 2 3) 3) )

#22 Count a Sequence
(de f22 (L)
   (for I L I) )
(test
   NIL
   (f22 ()) )
(test
   3
   (f22 (1 2 3)) )

#24 Sum It All Up
(de f24 (L)
   (if L (apply + @) 0) )
(test
   0
   (f24 ()) )
(test
   6
   (f24 (1 2 3)) )

#25 Find the odd numbers
(de f25 (L)
   (filter '((I) (bit? 1 I)) L) )
(test
   (1 3 5)
   (f25 (1 2 3 4 5)) )

#23 Reverse a Sequence
(de f23 (L)
   (make
      (for I L
         (yoke I) ) ) )
(test
   (3 2 1)
   (f23 (1 2 3)) )

#27 Palindrome Detector
(de f27 (L)
   (= L (reverse L)) )
(test
   NIL
   (f27 (1 2)) )
(test
   T
   (f27 (1 1 2 1 1)) )
(test
   T 
   (f27 (chop "racecar")) )

#26 Fibonacci Sequence
(de f26 (N)
   (let L (list 1 1)
      (do (- N 2)
         (push 'L (+ (car L) (cadr L))) )
      (flip L) ) )
(test
   (1 1 2)
   (f26 3) )
(test
   (1 1 2 3 5 8)
   (f26 6) )

#38 Maximum value
(de f38 (N . @)
   (while (args)
      (when (> (next) N) (setq N (arg))) )
   N )
(test
   8
   (f38 1 8 3 4) )
(test
   67
   (f38 45 67 11) )

#29 Get the Caps
(de f29 (L)
   (pack (filter upp? (chop L))) )
(test
   "HLOWRD"
   (f29 "HeLlO, WoRlD!") )
(test
   NIL
   (f29 "nothing") )
(test
   "AZ"
   (f29 "$#A(*&987Zf") )

#32 Duplicate a Sequence
(de f32 (Lst)
   (mapcan list Lst Lst) )
(test
   (1 1 2 2 3 3)
   (f32 (1 2 3)) )
(test
   '(a a b b c c)
   (f32 '(a b c)) )
(test
   '((1 2) (1 2) (3 4) (3 4)) 
   (f32 '((1 2) (3 4))) )

#48 Intro to some
(let (S (2 7 6)  R (5 6 7 8))
   (test
      6
      (find
         '((I) (member I S))
         R ) )
   (test
      6
      (find
         '((I) (not (bit? 1 I)))
         R ) ) )

#34 Implementing range
(de f34 (X Y)
   (make
      (for (N X (>= Y N) (inc N))
         (link N) ) ) )
(test
   (range 1 4)
   (f34 1 4) )
(test
   (range -2 2)
   (f34 -2 2) )
(test
   (range 5 8)
   (f34 5 8) )

#28 Flatten a Sequence
(de f28 (L)
   (make
      (recur (L)
         (if (atom L)
            (link L)
            (mapc recurse L) ) ) ) )
(test
   (1 2 3 4 5 6)
   (f28 '((1 2) 3 (4 (5 6)))) )
(test
   '(a)
   (f28 '((((a))))) )

#39 Interleave Two Seqs
(de f39 (L1 L2)
   (let 
      (M (min (length L1) (length L2))
         L1 (head M L1)
         L2 (head M L2) )
      (mapcan list L1 L2) ) )
(test
   '(1 a 2 b 3 c)
   (f39 (1 2 3) '(a b c)) )
(test
   (1 3 2 4)
   (f39 (1 2) (3 4 5 6)) )
(test
   (1 5)
   (f39 (1 2 3 4) (5)) )

#42 Factorial Fun
(de f42 (N)
   (apply * (range 1 N) ) )
(test 1 (f42 1))
(test 6 (f42 3))
(test 120 (f42 5))
(test 40320 (f42 8))

#30 Compress a Sequence
(de f30 (Lst)
   (mapcon
      '((L)
         (unless (= (car L) (cadr L))
         (cons (car L)) ) )
      Lst ) )
(test
   "Leroy"
   (pack (f30 (chop "Leeeeeerrroyyy"))) )

#47 Contain Yourself
(test
   '(Q 42)
   (asoq 'Q '((a 1 2 3) (Q 42) (ok "yes"))) )
(test
   (3 4 5 6)
   (member 3 (1 2 3 4 5 6)) )

#45 Intro to Iterate
(de iterate ("Fun" "X")
   (list 'job (lit (env '("Fun" "X")))
      '(prog1 "X" (setq "X" ("Fun" "X"))) ) )
(de take ("N" . "Prg")
   (make (do "N" (link (run "Prg")))) )
(test
  (1 4 7 10 13)
  (take 5 `(iterate '((N) (+ 3 N)) 1)) )

#33 Replicate a Sequence
(de f33 (L N)
   (make
      (for X L
         (do N (link X)) ) ) )
(test
   '(1 2 3)
   (f33 (1 2 3) 1) )
(test
   '(1 1 2 2 3 3)
   (f33 (1 2 3) 2) )
(test
   '((1 2) (1 2) (3 4) (3 4))
   (f33 '((1 2) (3 4)) 2) )

#40 Interpose a Seq
(de f40 (C L)
   (head -1 
      (make
         (for I L
            (link I C) ) ) ) )
(test
   (1 0 2 0 3)
   (f40 0 (1 2 3)) )
(test
   "one, two, three"
   (pack (f40 ", " '("one" "two" "three"))) )

#31 Pack a Sequence
(de consecDups (Lst)
   (make
      (let Last NIL
         (for X Lst
            (if (= X (car Last))
               (conc Last (cons X))
               (link (setq Last (cons X))) ) ) ) ) )
(test
   '((1 1) (2) (1 1 1) (3 3))
   (consecDups (1 1 2 1 1 1 3 3)) )
(test
   '(((1 2) (1 2)) ((3 4)))
   (consecDups '((1 2) (1 2) (3 4))) )

#41 Drop Every Nth Item
(de drop (Lst N)
   (make
      (for (I . X) Lst
         (unless (=0 (% I N))
            (link X) ) ) ) )
(test
   '(1 2 4 5 7 8)
   (drop (1 2 3 4 5 6 7 8) 3) )
(test
   '(a c e)
   (drop '(a b c d e f) 2) )

#52 Intro to Destructuring
(when (== 64 64) # (after v3.1.9.2)
   (test
      (2 4)
      (let ((A B C D E F G) (range 1 7)) (list B D)) ) )

# manual destructuring for pil32
(de destru (A E)
   (if (atom A)
      (and A (list A E))
      (and (atom E) (off E))
      (append
         (destru (car A) (car E))
         (destru (cdr A) (cdr E)) ) ) )
(test
   '(0 1 (3 4) 777)
   (let
      (A 0
      ~(destru '(B NIL . C) (range 1 4))
      Z 777 )
      (list A B C Z) ) )

#49 Split a sequence
(de f49 (N L)
   (list (cut N 'L) L) )
(test
   '((1 2 3) (4 5 6))
   (f49 3 (1 2 3 4 5 6)) )
(test
   '((a) (b c d))
   (f49 1 '(a b c d)) )
(test
   '(((1 2) (3 4)) ((5 6)))
   (f49 2 '((1 2) (3 4) (5 6))) )

#51 Advanced Destructuring
(de f51 (A E)
   (if (atom A)
      (and A (list (cons A E)))
      (and (atom E) (off E))
      (append
         (f51 (car A) (car E))
         (f51 (cdr A) (cdr E)) ) ) )
(test
   '(1 2 (3 4 5) (1 2 3 4 5))
   (let D (1 2 3 4 5)
      (bind (f51 '(A B . C) D)
         (list A B C D) ) ) )

#83 A Half-Truth
(de f83 @
   (and (apply or (rest)) (apply nand (rest))) )
(test
   NIL
   (f83 NIL NIL) )
(test
   T
   (f83 T NIL) )
(test
   T
   (f83 NIL T NIL) )
(test
   NIL
   (f83 T T T) )
(test
   T
   (f83 T T T NIL) )

#61 Map Construction
(de f61 (X Y)
   (mapcar
      '((I J)
         (list I J) )
      X
      Y ) )
(test
   '((a 1) (b 2) (c 3))
   (f61 '(a b c) (1 2 3)) )
(test
   '((foo foo) (bar bar))
   (f61 '(foo bar) '(foo bar baz)) )

#66 Greatest Common Divisor
(de f66 (A B)
   (until (=0 B)
      (let M (% A B)
         (setq A B B M) ) )
   (abs A) )
(test
   2
   (f66 2 4) )
(test
   5
   (f66 10 5) )
(test
   1
   (f66 5 7) )
(test
   33
   (f66 1023 858) )

#166 Comparisons
(de f166 (Fun X Y)
   (cond
      ((Fun X Y) ':lt)
      ((Fun Y X) ':gt)
      (T ':eq) ) )
(test
   ':gt
   (f166 < 5 1) )
(test
   ':eq
   (f166 
      '((X Y) (< (length X) (length Y)))
      "pear"
      "plum" ) )
(test
   ':lt
   (f166
      '((X Y) (< (% X 5) (% Y 5)))
      21
      3 ) )
(test
   ':gt
   (f166 > 0 2) )

#81 Set Intersection
(de f81 (Lst1 Lst2)
   (filter '((X) (member X Lst2)) Lst1) )
(test
   (2 3)
   (f81 (0 1 2 3) (2 3 4 5)) )
(test
   NIL
   (f81 (0 1 2) (3 4 5)) )
(test
   '(a c d)
   (f81 '(a b c d) '(c e a f d)) )

#62 Re-implement Iterate
# take and iterate from easy.l #45
(test
   (1 2 4 8 16)
   (take 5 `(iterate '((N) (* 2 N)) 1)) )
(test
   (take 9 (pop '((1 2 3 .))))
   (take 9 `(iterate '((N) (inc (% N 3))) 1)) )

#107 Simple closures
(de fn107 (N)
   (curry (N) (X) (** X N)) )
(test
   256
   ((fn107 2) 16) )
(test
   (1 8 27 64)
   (mapcar (fn107 3) (1 2 3 4)) )
(test
   (1 2 4 8 16)
   (mapcar '((X) ((fn107 X) 2)) (0 1 2 3 4)) )

#99 Product Digits
(de f99 (X Y)
   (mapcar format (chop (* X Y))) )
(test
   (1)
   (f99 1 1) )
(test
   (8 9 1)
   (f99 99 9) )
(test
   (9 8 9 0 1)
   (f99 999 99) )

#90 Cartesian Product
(de f90 (L1 L2)
   (mapcan
      '((Y) (mapcar '((X) (cons X Y)) L1))
      L2 ) )
(test
   '((1 . 4) (2 . 4) (3 . 4) (1 . 5) (2 . 5) (3 . 5))
   (f90 (1 2 3) (4 5)) )

#63 Group a Sequence
(de f63 (Fun Lst)
   (group
      (mapcar '((X) (cons (Fun X) X)) Lst) ) )
(test
   '((NIL 1 3) (T 6 8))
   (f63 '((N) (> N 5)) (1 3 6 8)) )
(test
   '((1 (1) (3)) (2 (1 2) (2 3)) (3 (1 2 3)))
   (f63 length '((1) (1 2) (3) (1 2 3) (2 3))) )   

#122 Read a binary number
(test 0 (bin "0"))
(test 1365 (bin "10101010101"))

#88 Symmetric Difference
(de f88 (Lst1 Lst2)
   (conc 
      (diff Lst1 Lst2)
      (diff Lst2 Lst1) ) )
(test
   '(2 4 6 7)
   (f88 (1 2 3 4 5 6) (1 3 5 7)) )
(test
   (4 5 6)
   (f88 () (4 5 6)) )
(test
   '((1 2) (3 4))
   (f88 '((1 2) (2 3)) '((2 3) (3 4))) )

#143 dot product
(de f143 (L1 L2)
   (apply + (mapcar * L1 L2)) )
(test
   0
   (f143 (0 1 0) (1 0 0)) )
(test
   32
   (f143 (1 2 3) (4 5 6)) )
(test
   256
   (f143 (2 5 6) (100 10 1)) )

#126 Through the Looking Class

#135 Infix Calculator
(de f135 (N . Args)
   (for (L Args  L)
       (setq N ((pop 'L) N (pop 'L))) )
   N )
(test
   7
   (f135 5 + 2) )
(test
   42
   (f135 38 + 48 - 2 / 2) )
(test
   8
   (f135 10 / 2 - 1 * 2) )
(test
   72
   (f135 20 / 2 + 2 + 4 + 8 - 6 - 10 * 9) )

#157 Indexing Sequences
(de f157 (L)
   (make
      (for (I . X) L
         (link (list X (dec I))) ) ) )
(test
   '((a 0) (b 1) (c 2))
   (f157 '(a b c)) )
(test
   '((0 0) (1 1) (3 2))
   (f157 (0 1 3)) )
(test
   '(((foo) 0) ((bar baz) 1))
   (f157 '((foo) (bar baz))) )

#97 Pascal's Triangle
(de f97 (N)
   (let C 1
      (make
         (for K N
            (link C)
            (setq C (*/ C (- N K) K)) ) ) ) )
(test
   (1)
   (f97 1) )
(test
   '(    (1)
        (1 1) 
       (1 2 1) 
      (1 3 3 1) 
     (1 4 6 4 1) )
   (mapcar f97 (range 1 5)) )
(test
   (1 10 45 120 210 252 210 120 45 10 1)
   (f97 11) )

#118 Re-implement Map
(de f118 (F L)
   (make
      (for I L
         (link (F I)) ) ) )
(test
   (3 4 5 6 7)
   (f118 inc (2 3 4 5 6)) )

#120 Sum of square of digits
(de f120 (L)
   (cnt
      '((I)
         (<
            I
            (sum
               '((J) (* J J))
               (mapcar format (chop I)) ) ) ) 
      L ) )
(test
   8
   (f120 (range 1 10)) )
(test
   19
   (f120 (range 1 30)) )
(test
   50
   (f120 (range 1 100)) )
(test
   50
   (f120 (range 1 1000)) )

#95 To Tree, or not to Tree
(de f95 (L)
   (or
      (atom L)
      (and
         (cddr L)
         (not (cdr @))
         (f95 (cadr L))
         (f95 (caddr L)) ) ) )
(test
   T
   (f95 '(:a (:b nil nil) nil)) )
(test
   NIL
   (f95 '(:a (:b nil nil))) )
(test
   T
   (f95 '(1 nil (2 (3 nil nil) (4 nil nil)))) )
(test
   NIL
   (f95 '(1 (2 nil nil) (3 nil nil) (4 nil nil))) )
(test
   T
   (f95 '(1 (2 (3 (4 nil nil) nil) nil) nil)) )

#128 Recognize Playing Cards
(setq *Suit 
   '(("D" . diamond) ("S" . spade) 
      ("H" . heart) ("C" . club) ) )
(setq *Rank
   '(("2" . 0) ("3" . 1) ("4" . 2) 
      ("5" . 3) ("6" . 4) ("7" . 5) 
      ("8" . 6) ("9" . 7) ("T" . 8) 
      ("J" . 9) ("Q" . 10) ("K" . 11) 
      ("A" . 12) ) )
(de f128 (S)
   (let S (chop S)
      (cons
         (cdr (assoc (car S) *Suit))
         (cdr (assoc (cadr S) *Rank)) ) ) )
(test
   '(diamond . 10)
   (f128 "DQ") )
(test
   '(heart . 3)
   (f128 "H5") )
(test
   '(club . 12)
   (f128 "CA") )
(test
   (range 0 12)
   (mapcar 
      '((I) (cdr (f128 I))) 
      '(S2 S3 S4 S5 S6 S7
         S8 S9 ST SJ SQ SK SA) ) )

#100 Least Common Multiple
(de gcd (A B)
   (until (=0 B)
      (let M (% A B)
         (setq A B B M) ) )
   (abs A) )
(de lcm (A B)
   (abs (*/ A B (gcd A B))) )

# reduce from elementary.l (task #64)
(test
   6
   (reduce lcm (2 3)) )
(test
   105
   (reduce lcm (3 5 7)) )

#173 Intro to Destructuring 2
# destru from easy.l (task #52)
(test
   3
   (let
      (~(destru '(F A) '(+ (range 0 2))))
      (apply F A) ) )
(test
   3
   (let
      (~(destru '((F A) B) '((+ 1) 2)))
      (F A B) ) )
(test
   3
   (let
      (~(destru '(F A) '(inc 2)))
      (F A) ) )

#147 Pascal's Trapezoid
# take and iterate from easy.l #45
(de f147 (L)
   (make
      (link (car L))
      (for (I L (cdr I) (cdr I))
         (link (+ (car I) (cadr I))) )
      (link (last L)) ) )
(de second "Prg"
   (do 2 (run "Prg")) )
(test
   (2 5 5 2)
   (second `(iterate f147 (2 3 2))) ) 
(test
   '((1) (1 1) (1 2 1) (1 3 3 1) (1 4 6 4 1))
   (take 5 `(iterate f147 (1))) )
(test
   '((3 1 2) (3 4 3 2))
   (take 2 `(iterate f147 (3 1 2))) )
(test
   (take 100 `(iterate f147 (2 4 2)))
   (cdr (take 101 `(iterate f147 (2 2)))) )

#96 Beauty is Symmatry
(de f96 (L R)
   (cond
      ((and (atom L) (atom R)) (= L R))
      ((and (pair L) (pair R))
         (and
            (= (car L) (car R))
            (f96 (cadr L) (caddr R))
            (f96 (caddr L) (cadr R)) ) )
      (T NIL) ) )
(setq *TESTS
   '((T (:a (:b nil nil) (:b nil nil)))
      (NIL (:a (:b nil nil) nil))
      (NIL (:a (:b nil nil) (:c nil nil)))
      (T (1 (2 nil (3 (4 (5 nil nil) (6 nil nil)) nil))
         (2 (3 nil (4 (6 nil nil) (5 nil nil))) nil) ) )
      (NIL (1 (2 nil (3 (4 (5 nil nil) (6 nil nil)) nil))
         (2 (3 nil (4 (5 nil nil) (6 nil nil))) nil) ) )
      (NIL (1 (2 nil (3 (4 (5 nil nil) (6 nil nil)) nil))
         (2 (3 nil (4 (6 nil nil) nil)) nil) ) ) ) )
(for I *TESTS
   (test
      (car I)
      (f96 
         (cadadr I)
         (car (cddadr I)) ) ) )

#146 Trees into tables
(de f146 (L)
   (make
      (for (X L X (cddr X))
         (for (Y (cadr X) Y (cddr Y))
            (link (list (car X) (car Y)) (cadr Y)) ) ) ) )
(test
   '((a p) 1 (a q) 2 (b m) 3 (b n) 4)
   (f146 '(a (p 1 q 2) b (m 3 n 4))) )
(test
   '(((1) a) b ((1) c) d ((2) q) r ((2) s) t ((2) u) v ((2) w) x)
   (f146 '((1) (a b c d) (2) (q r s t u v w x))) )
(test
   '((m 1) (a b c) (m 3) NIL)
   (f146 '(m (1 (a b c) 3 NIL))) )

#153 Pairwise Disjoint Sets
(de f153 (L)
   (catch NIL
      (for (X L X (cdr X))
         (for Y (cdr X)
            (when (sect (car X) Y)
               (throw NIL) ) ) )
      T ) )
(test
   NIL
   (f153 '((a b c d e) (a b c d) (a b c) 
      (a b) (a) ) ) )
(test
   T
   (f153 '(((1 2 3) (4 5)) ((1 2) (3 4 5)) 
      ((1) (2) 3 4 5) (1 2 (3 4) (5)) ) ) )
