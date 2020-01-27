(de splitme (Str)
   (let (Str (chop Str)  Fin)
      (glue
         ", "
         (make
            (for X Str
               (if (= X (car Fin))
                  (conc Fin (cons X))
                  (link (setq Fin (cons X))) ) ) ) ) ) )
#(println (splitme 'mmmike))
#(println (splitme "aab55cc"))
(prinl (splitme "gHHH5YY++///\\"))

(msg 'ok)
(bye)
