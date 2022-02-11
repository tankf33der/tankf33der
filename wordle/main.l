(load "wordlist.l")
(de green (A)
   (prin "^[[30;102m" A "^[[0m") )
(de gray (A)
   (prin "^[[30;47m" A "^[[0m") )
(de yellow (A)
   (prin "^[[30;103m" A "^[[0m") )
(de display (Lst G)
   (mapc
      '((A B)
         (case A
            (1 (gray B))
            (2 (yellow B))
            (3 (green B)) ) )
      Lst
      G ) )
(de compare (W G)
   (make
      (for (I . X) G
         (link
            (cond
               ((= X (get W I)) 3)
               ((member X W) 2)
               (T 1) ) ) ) ) )
(test
   (1 2 1 2 2)
   (compare
      (chop "rebus")
      (chop "arise") ) )
(test
   (3 1 2 1 2)
   (compare
      (chop "rebus")
      (chop "route") ) )
(test
   (3 2 1 2 3)
   (compare
      (chop "rebus")
      (chop "rules") ) )
(test
   (3 3 3 3 3)
   (compare
      (chop "rebus")
      (chop "rebus") ) )

(green 'green)
(gray 'gray)
(yellow 'yellow)
(prinl)
(display (3 1 2 3 3) (chop "rebus"))


(msg 'ok)
(bye)
