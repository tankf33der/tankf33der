(co 'fibo
   (let (A 0  B 1)
      (yield 'ready)
      (while
         (yield
            (swap 'B (+ (swap 'A B) B)) ) ) ) )

# 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610
(do 15
   (printsp (yield 'next 'fibo)) )
(prinl)
(yield NIL 'fibo) # stop generator

(msg 'ok)
(bye)
