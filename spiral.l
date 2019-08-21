(load "@lib/simul.l")
 
# 5 - c3
# 9 - e5 
(de spiral (N)
   (let
      (G (grid N N)
         This 'c3
         Dir '(north west south east .) )
      (=: val 1) 
      #(for (X 2 (>= (* N N) X) (inc X)) 
      (for (X 2 (>= N X) (inc X)) 
         (setq This ((car Dir) This))
         (=: val X)
         (or
            (with ((car Dir) This) (: val))
            (with ((cadr Dir) This) (: val))
            (pop 'Dir) )
      )
      (setq This 'c3)
      (println 
         'val (: val)
         (sum
            '((D) (with (D This) (: val)))
            (quote
               west east south north
               ((X) (south (west X)))
               ((X) (north (west X)))
               ((X) (south (east X)))
               ((X) (north (east X))) ) )
      )

      (mapc
         '((L)
            (for This L
               (prin (align 3 (if (: val) @ "#"))) )
            (prinl) )
         G )
   )
)

(de spiralSum NIL 
   (let
      (G (grid 9 9)
         This (get G 5 5)
         A 1
         Dir '(north west south east .) )
      (=: val A)
      (while (>= 265149 A)
         (setq This ((car Dir) This))
         (setq A 
            (=: 
               val
               (sum
                  '((D) (with (D This) (: val)))
                  (quote
                     west east south north
                     ((X) (south (west X)))
                     ((X) (north (west X)))
                     ((X) (south (east X)))
                     ((X) (north (east X))) ) ) ) )
         (or
            (with ((car Dir) This) (: val))
            (with ((cadr Dir) This) (: val))
            (pop 'Dir) ) )
      A ) )

(test 266330 (spiralSum 9))

(msg 'ok)
(bye)
