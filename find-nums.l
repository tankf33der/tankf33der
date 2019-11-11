(de f1 (Lst)
   (filter num? (fish atom Lst)) )
(de f2 (Lst)
   (mapcan
      '((L)
         (recur (L)
            (if (num? L) (cons L) (mapcan recurse L)) ) )
      Lst ) )
(test
   (f1 (range 1 5))
   (f2 (range 1 5)) )
(test
   (f1 '(1 (2) ((3))))
   (f2 '(1 (2) ((3)))) )
(msg 'ok)
(bye)
