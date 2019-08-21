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

# Tests
(test
   (fully
      version?
      (quote
         (17 2 1)
         (17 2 10)
         (17 2 1)
         (17 11 10)
         (17 11 1)
         (16 11 1)
         (16 11 0)
         (16 7 20) ) )
   (not
      (fully
         version?
         (quote
            (15 10 3)
            (15 3 3)
            (16 3 10)
            (16 6 1) ) ) ) )

(msg 'ok)
(bye)

