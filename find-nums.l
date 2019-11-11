(de f2 (Lst)
   (mapcan
      '((L)
         (recur (L)
            (if (num? L) (cons L) (mapcan recurse L)) ) )
      Lst ) )
(test
   (fish num? (range 1 5))
   (f2 (range 1 5)) )
(test
   (fish num? '(1 (2) ((3))))
   (f2 '(1 (2) ((3)))) )
(msg 'ok)
(bye)
