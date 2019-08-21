(de zeroM (Lst)
   (fully '((L) (fully =0 L)) Lst) )
(test
   NIL
   (zeroM '((1 0 0) (0 1 0) (0 0 1))) )
(test
   T
   (zeroM '((0 0) (0 0))) )
(msg 'ok)
(bye)
