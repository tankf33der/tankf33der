(de 2lists (L1 L2)
   (mapcan
      '((I)
         (mapcar
            '((A) ((if (atom A) list cons) I A))
            L2 ) )
      L1 ) )
(de reduce (L . @)
   (ifn (rest) L (2lists L (apply reduce (rest)))) )
(de cartesian (L . @)
   (and L (rest) (pass reduce L)) )

(test
   NIL
   (cartesian (1 2)) )
(test
   NIL
   (cartesian NIL (1 2)) )
(test
   '((1 3) (1 4) (2 3) (2 4))
   (cartesian (1 2) (3 4)) )
(test
   '((3 1) (3 2) (4 1) (4 2))
   (cartesian (3 4) (1 2)) )
(test
   (quote
      (1776 7 4 0) (1776 7 4 1) (1776 7 14 0) (1776 7 14 1)
      (1776 7 23 0) (1776 7 23 1) (1776 12 4 0) (1776 12 4 1) 
      (1776 12 14 0) (1776 12 14 1) (1776 12 23 0) (1776 12 23 1) 
      (1789 7 4 0) (1789 7 4 1) (1789 7 14 0) (1789 7 14 1) 
      (1789 7 23 0) (1789 7 23 1) (1789 12 4 0) (1789 12 4 1) 
      (1789 12 14 0) (1789 12 14 1) (1789 12 23 0) (1789 12 23 1) )
   (cartesian (1776 1789) (7 12) (4 14 23) (0 1)) )
(test
   (quote
      (1 30 500) (1 30 100) (2 30 500) 
      (2 30 100) (3 30 500) (3 30 100) ) 
   (cartesian (1 2 3) (30) (500 100)) )
(test 
   NIL
   (cartesian (1 2 3) NIL (500 100)) )
#{
(println
   (cartesian (1 2)) )
(println
   (cartesian NIL (1 2)) )
(println
   (cartesian (1 2) (3 4)) )
(println
   (cartesian (3 4) (1 2)) )
(println
   (cartesian (1776 1789) (7 12) (4 14 23) (0 1)) )
(println
   (cartesian (1 2 3) (30) (500 100)) )
(println 
   (cartesian (1 2 3) NIL (500 100)) )
}#

#(msg 'ok)
#(bye)

