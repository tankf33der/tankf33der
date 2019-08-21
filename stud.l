(de mycopy (X N)
   (if (=0 N)
      NIL
      (cons X (mycopy X (dec N))) ) )
(println
   (mycopy 'A 4) )

(let Lst (15 20 25 30 35 40 45 50 55 60)
   (for (L Lst L (cdr L))
      (println 'L L) )
   (for (L Lst L (cdddr L))
      (println 'carL (car L)) ) )

# 1
(de z1 (Lst)
   (or
      (find atom Lst)
      '(NONE OF THESE ELEMENTS IS AN ATOM) ) )
(println
   (z1 '((1 c) c (2 2 c)))
   (z1 '((1 c) (c) (2 2 c))) )


(bye)

