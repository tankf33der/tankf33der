#1 Nothing but the Truth
(test T T)

#2 Simple Math
(test 4 (- 10 (* 2 3)))

#3 Intro to Strings
(test "HELLO WORLD" (uppc "hello world"))

#4 Intro to Lists
(test '(a b c) (list 'a 'b 'c))

#5 Lists: conj
(test (1 2 3 4) (cons 1 (2 3 4)))

#6 Intro to Vectors
# lists are enough, see #4

#7 Vectors: conj
# lists are enough, see #5

#8 Intro to Sets
(test
   '(a b c d)
   (uniq '(a a b c c c c d d)) )

#9 Sets: conj
# lists are enough, see #5

#10 Intro to Maps
# see also assoc and lup
(test
   '(Q 42)
   (asoq 'Q '((a 1 2 3) (Q 42) (ok "yes"))) )

#11 Maps: conj
# lists are enough, see #5

#12 Intro to Sequences
(test 3 (car (3 2 1)))
(test 3 (last (1 2 3)))

#13 Sequences: rest
(test (20 30 40) (cdr (10 20 30 40)))

#14 Intro to Functions
(test
   8
   ('((X) (+ 5 X)) 3) )

#15 Double Down
(test
   4
   ('((X) (* 2 X)) 2) )
   
#16 Hello World
(test
   "Hello, Dave!"
   ('((S) (pack "Hello, " S "!")) 'Dave) )

#17 Sequences: map
(test
   (6 7 8)
   (mapcar
      '((X) (+ 5 X))
      (1 2 3) ) )

#18 Sequences: filter
(test
   (6 7)
   (filter
      '((X)
         (< 5 X) )
      (3 4 5 6 7) ) )

#35 Local bindings
(test
   7
   (let X 5
      (+ 2 X) ) )

#36 Let it Be
(test
   10
   (let (X 7  Y 3)
      (+ X Y) ) )
(test
   4
   (let (Y 3  Z 1)
      (+ Y Z) ) )
(test
   1
   (let Z 1
      Z ) )

#37 Regular Expressions
(test
   "ABC"
   (pack
      (filter upp? (chop "bA1B3Ce ")) ) )
(when (and (== 64 64) (= *OS "Linux"))
   (test
      "ABC" 
      (pack
         (let (P "[A-Z]+"  S "bA1B3Ce ")
            (use (R M)
               (and 
                  (=0
                     (native
                        "@"
                        "regcomp"
                        'I
                        '(R (64 B . 64))
                        P
                        1 ) )
                  (make
                     (while 
                        (=0
                           (native
                              "@"
                              "regexec"
                              'I
                              (cons NIL (64) R)
                              S
                              1
                              '(M (8 I . 2))
                              0 ) )
                        (setq S (nth (chop S) (inc (car M))))
                        (chain (cut (- (cadr M) (car M)) 'S))
                        (setq S (pack S)) ) ) ) ) ) ) ) )

#64 Intro to Reduce
(de reduce ("Fun" "Lst")
   (let "A" (car "Lst")
      (for "N" (cdr "Lst")
         (setq "A" ("Fun" "A" "N")) )
      "A" ) )
(test
   15
   (reduce + (1 2 3 4 5)) )
(test
   NIL 
   (reduce + ()) )

#57 Simple Recursion
(de f57 (X)
   (when (> X 0)
      (cons X (f57 (dec X))) ) )
(test
   (5 4 3 2 1)
   (f57 5) )

#71 Rearranging Code: ->
(use ->
   (undef '->)
   (de -> ("X" . "A")
      (for "Form" "A"
         (setq "X" (apply (car "Form") (cdr "Form") "X")) ) )
   (test
      5
      (->
         (2 5 4 1 3 6)
         (reverse)
         (cdr)
         (sort)
         (last) ) ) )

#68 Recurring Theme
(test
   (7 6 5 4 3)
   (let (X 5  R ())
      (recur (X R)
         (if (gt0 X)
            (recurse (dec X) (append R (cons (+ 2 X))))
            R ) ) ) )

#72 Rearranging Code: ->>
(de ->> ("X" . "A")
   (for "Form" "A"
      (setq "X" (eval (append "Form" (cons "X")))) ) )
(test
   11
   (->>
      (2 5 4 1 3 6)
      (tail -2)
      (head 3)
      (mapcar inc)
      (apply +) ) )

#134 A NIL key
(let M '((a NIL) (b 2))
   (de f134 (M K)
      (when (asoq K M)
         (= NIL (cadr @)) ) )

   (test T (f134 M 'a))
   (test NIL (f134 M 'b))
   (test NIL (f134 M 'c)) )

#145 For the win
(test
   (1 5 9 13 17 21 25 29 33 37)
   (make
      (for I 40 
         (when (= 1 (% I 4)) (link I)) ) ) )

#162 Logical failsity and truth
(test 1 (ifn NIL 1 0))
(test 1 (if T 1 0))
(test 1 (if () 0 1))
(test 1 (if (0) 1 0))
(test 1 (if 0 1 0))
(test 1 (if 1 1 0))

#161 Subset and Superset
(de superset? (S1 S2)
   (not (diff S2 S1)) )
(de subset? (S1 S2)
   (not (diff S1 S2)) )
(test T (superset? (1 2) (2)))
(test T (subset? (1) (1 2)))
(test T (superset? (1 2) (1 2)))
(test T (subset? (1 2) (1 2)))

#156 Map Defaults
(de f156 ("K" "M")
   (make
      (for "I" "M"
         (link (list "I" "K")) ) ) )
(test
   '((a 0) (b 0) (c 0))
   (f156 0 '(a b c)) )
(test
   '((1 "x") (2 "x") (3 "x"))
   (f156 "x" (1 2 3)) )
(test
   '((foo (a b)) (bar (a b)))
   (f156 '(a b) '(foo bar)) )

