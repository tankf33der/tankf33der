(load "circR.l")

(let (L NIL  Lst (range 1 5))
   (circR 'L Lst)
   (test 0 (cadr L))
   (test 5 (cddr L))
   (do 3
      (popR 'L) )
   (test 3 (cadr L))
   (resetR 'L)
   (do 123
      (popR 'L) )
   (test 123 (cadr L))
   (test 4 (caar L))
   (resetR 'L)
   (test 0 (cadr L))
   (test 1 (popR 'L)) )

(let (L NIL  Lst (range 1 5))
   (circA 'L Lst)
   (test 5 (last L))
   (and
      (do 3 (pop L))
      (test 3 @) )
   (circA 'L (cdr L))
   (and
      (do 3 (pop L))
      (test 3 @) ) )

(msg 'circR-OK)
(bye)
