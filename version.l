# School
(de version? (L)
   (>= L (version T)) )

# Student
(de version? (L V)
   (default V (version T))
   (cond
      ((or
         (not L)
         (> (car L) (car V)) ) T )
      ((= (car L) (car V))
         (version? (cdr L) (cdr V)) ) ) )

# Enterprise
(de version? (Lst)
   (let Ver (version T)
      (nand
         (find
            '((L V)
               (and
                  (- L V)
                  (or (gt0 @) (lt0 @)) ) )
         Lst
         Ver )
      (lt0 @@) ) ) )

(test NIL (version? (10 10 10)))
(test T (version? (21 10 1)))

(msg 'ok)
(bye)

