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

(println (stack))


(msg 'ok)
(bye)
