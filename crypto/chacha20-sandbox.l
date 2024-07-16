(co '+
   (+ 100 (yield)) )
(test 112 (yield 12 '+))

(co "+"
   (+ (yield) (yield)) )
(yield 101 "+")
(test 202 (yield 101 "+"))

(co "1+"
   (yield)
   (loop
      (yield (+ 100 (yield))) ) )
(yield 'new "1+")
(test 223 (yield 123 "1+"))
(yield 'new "1+")
(test 101 (yield 1 "1+"))

(co "2+"
   (yield)
   (loop
      (yield (+ (yield) (yield))) ) )
(yield 'new "2+")
(yield 100 "2+")
(test 200 (yield 100 "2+"))
(yield 'new "2+")
(yield 1000 "2+")
(test 2000 (yield 1000 "2+"))

(co '+
   (yield)
   (loop
      (yield (apply + (yield))) ) )
(de plus (Lst)
   (co '+ T)
   (yield Lst '+) )
(test 3 (plus (1 2)))

(de plus2 (Lst)
   (co 'plus2
      (co '+ T)
      (yield Lst '+) ) )
(test 6 (plus2 (1 2 3)))

(co 'a
   (yield)
   (let A 0
      (loop
         (if (num? (yield))
            (yield (setq A @))
            (yield A) ) ) ) )
# GET
(co 'a T)
(test 0 (yield NIL 'a))
# SET
(co 'a T)
(test 123 (yield 123 'a))
# GET
(co 'a T)
(test 123 (yield NIL 'a))
# SET
(co 'a T)
(yield -123 'a)
# GET
(co 'a T)
(test -123 (yield NIL 'a))

(de set_ (Var Val)
   (co 'set_
      (co Var T)
      (yield Val Var) ) )
(de get_ (Var)
   (co 'get_
      (co 'a T)
      (yield NIL Var) ) )

(set_ 'a 10)
(test 10 (get_ 'a))
(set_ 'a (+ 100 (get_ 'a)))
(test 110 (get_ 'a))




(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )
(de rol32 (X C)
   (| (mod32 (>> (- C) X)) (>> (- 32 C) X)) )

(test 3755744309 (mod32 12345678901))

(co "mod32"
   (yield)
   (loop
      (yield (& (yield) `(hex "FFFFFFFF"))) ) )
(de mod32- (N)
   (co 'mod32-
      (co "mod32" T)
      (yield N "mod32") ) )
(test 1234 (mod32- 1234))
(test 3755744309  (mod32- 12345678901))

(co "shift"
   (yield)
   (loop
      (yield (>> (yield) (yield))) ) )
(de shift- (C N)
   (co 'shift-
      (co "shift" T)
      (yield C "shift")
      (yield N "shift") ) )
(test
   (>> -4 123456)
   (shift- -4 123456) )
(test
   (>> 4 123456)
   (shift- 4 123456) )

(co "minus"
   (yield)
   (loop
      (yield (- (yield) (yield))) ) )
(de minus- (A B)
   (co 'minus-
      (co "minus" T)
      (yield A "minus")
      (yield B "minus") ) )
(test
   (- 12345 5)
   (minus- 12345 5) )

(co "or"
   (yield)
   (loop
      (yield (| (yield) (yield))) ) )
(de or- (A B)
   (co 'or-
      (co "or" T)
      (yield A "or")
      (yield B "or") ) )
(test
   (| 12345 54321)
   (or- 12345 54321) )

(de rol32- (X C)
   (co 'rol32-
      (or-
         (mod32- (shift- (- C) X))
         (shift- (minus- 32 C) X) ) ) )
(test 3599171602 (rol32 1234567 16))
(test 3599171602 (rol32- 1234567 16))

#(make
#   (do 16
#      (link
#         (apply
#            |
#            (mapcar >> (-24 -16 -8 0) (cut 4 'Lst)) ) ) ) )

(let (Lst
        (conc
            (mapcar char (chop "expand 32-byte k"))
            (range 1 32)
            (range 1 16) )
        Data NIL
     )
     (setq Data
        (make
           (do 16
              (link
              (apply
                 |
                 (mapcar >> (0 -8 -16 -24) (cut 4 'Lst)) ) ) ) ) )
     (println (length Data) Data)
)




(println (stack))
# stop world
(for L (stack)
   (when (nT (car L)) (co (car L))) )
(println (stack))

(msg 'ok)
(bye)
