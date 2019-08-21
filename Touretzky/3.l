#3.1
(test
   NIL
   (not (= 3 (abs -3))) )

#3.2
(test 5 (/ (+ 8 2) 2))

#3.3
(test
   (+ (** 3 2) (** 4 2))
   (+ (* 3 3) (* 4 4)) )

#3.4 - ignored

#3.5
(de half (N)
   (/ N 2) )
(de cube (N)
   (* N N N) )
(de onemorep (A B)
   (= A (inc B)) )
(test 10 (half 20))
(test 27 (cube 3))
(test T (onemorep 4 3))

#3.6
(de pythag (A B)
   (sqrt (+ (* A A) (* B B))) )
(test 5 (pythag 3 4))

#3.7
(de miles-per-gallon
   (initial-odometer-reading
      final-odometer-reading
      gallons-consumed )
   (/ 
      (-
         final-odometer-reading
         initial-odometer-reading )
      gallons-consumed ) )
(test
   5
   (miles-per-gallon 120 320 40) )

#3.8 - ignored

#3.9
(test
   (5 6 7)
   (cons 5 (list 6 7)) )
(test
   '(5 list 6 7)
   (cons 5 '(list 6 7)) )
(test
   '(3 from 9 gives 6)
   (list 3 'from 9 'gives (- 9 3)) )
(test
   6
   (+
      (length '(1 foo 2 moo))
      (caddr '(1 foo 2 moo)) ) )
(test
   '(is short for construct)
   (cdr '(cons is short for construct)) )

#3.10
(test 'brown (caddr '(the quick brown fox)))
(test
   '(2 and 2 is 4)
   (list 2 'and 2 'is 4) )
(test
   5
   (+ 1 (length (list t t t t))) )
(test
   '(patrick seymour marvin)
   (cons 'patrick '(seymour marvin)) )
(test
   '(patrick seymour marvin)
   (cons 'patrick (list 'seymour 'marvin)) )

#3.11
(de longer-than (L1 L2)
   (> (length L1) (length L2)) )

#3.12
(de addlength (L)
   (cons (length L) L) )
(test
   '(3 1 2 3)
   (addlength (1 2 3)) )
(test
   '(4 3 a b c)
   (addlength (addlength '(a b c))) )
(test
   '(2 addlength '(a b c))
   (addlength '(addlength '(a b c))) )

#3.13
(de call-up (Caller Callee)
   (list 'hello Callee 'this 'is Caller 'calling) )
(test
   '(hello Wanda this is Fred calling)
   (call-up 'Fred 'Wanda) )

#3.14
(de crank-call (Caller Callee)
   '(hello Callee this is Caller calling) )
(test
   '(hello Callee this is Caller calling)
   (crank-call 'Fred 'Wanda) )

#3.15
(de scrabble (word)
   (list word 'is 'a 'word) )
(test
   '(AARDVARK is a word)
   (scrabble 'AARDVARK) )
(test
   '(word is a word)
   (scrabble 'word) )

#3.16
(de stooge (larry moe curly)
   (list larry (list 'moe curly) curly 'larry) )
(test
   '(moe (moe larry) larry larry)
   (stooge 'moe 'curly 'larry) )

#3.17 - ignored
#3.18 - ignored

#3.19
(test
   '(grapes of wrath)
   (cons 'grapes '(of wrath)) )
(test
   '(T is not NIL)
   (list T 'is 'not NIL) )
(test
   'list
   (first '(list moose goose)) )
(test
   'moose
   (first (list 'moose 'goose)) )
# (cons 'home ('sweet 'home)) )
# [3.l:146] !? ('sweet 'home)
# sweet -- Undefined

#3.20
(de mystery (X)
   (list (second X) (first X)) )
(test
   '(bear dancing)
   (mystery '(dancing bear)) )
# (mystery 'dancing 'bear) )
# [3.l:156] !? (second X)
# dancing -- List expected
(test
   '(NIL zowie)
   (mystery '(zowie)) )
(test
   '(second first)
   (mystery (list 'first 'second)) )

#3.21 - ignored

#3.22
# a
# pil +

# b
# failed expressions:
# (3 + 5)
# (+ 3 (5 6))
# (+ 3 'foo)

# c
(de myfun (A B)
   (list (list A) B) )
(test
   '((alpha) beta)
   (myfun 'alpha 'beta) )

# d
(de firstp (A L)
   (= A (car L)) )
(test
   T
   (firstp 'foo '(foo bar baz)) )
(test
   NIL
   (firstp 'boing '(foo bar baz)) )

# e
(de mid-add1 (L)
   (list (car L) (inc (cadr L)) (caddr L)) )
(de mid-add1-v2 (L) # pure magic
   (inc (cdr L)) 
   L )
(test
   '(take 3 cookies)
   (mid-add1 '(take 2 cookies)) )
(test
   '(take 3 cookies)
   (mid-add1-v2 '(take 2 cookies)) )

# f
(de f-to-c (F)
   (f*
      (frac (- F 32) 1)
      (f/ (frac 5 1) (frac 9 1)) ) )
(test
   (455 . 9)
   (f-to-c 123) )

# g - ignored

#3.23 - ignored

#3.24 - ignored

#3.25
(test
   '(cons T NIL)
   (list 'cons T NIL) )
(test
   '(T)
   (eval (list 'cons T NIL)) )
#(eval (eval (list 'cons T NIL)))
# undefined behavior
(test
   '(T)
   (apply cons '(T NIL)) )
(test
   NIL
   (eval NIL) )
(test
   '(eval NIL)
   (list 'eval NIL) )
(test
   NIL
   (eval (list 'eval NIL)) )

