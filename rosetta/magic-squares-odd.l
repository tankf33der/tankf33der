(load "@lib/simul.l")

(de magic (A)
   (let (Grid (grid A A T T)  Sum (/ (* A (inc (** A 2))) 2))
#{
      # cut important edge
      (with (last (last Grid))
         (con (: 0 1)) )
}#
      (with (get (car Grid) (inc (/ A 2)))
         (for N (* A A)
            (=: V N)
            (setq This
               (if (with (setq @@ (south (west This))) (not (: V)))
                  @@
                  (south This) ) )
         )
      )

      # display
      (mapc
         '((L)
            (for This L (prin (align 4 (: V))))
            (prinl) )
         Grid )
      (println
         (mapcar
            '((L) (sum '((This) (: V)) L))
            Grid ) )
      (println Grid)
      (println (apply mapcar (reverse Grid) list))
      (println
         (mapcar
            '((L) (sum '((This) (: V)) L)) 
            (apply mapcar (reverse Grid) list) ) )
      # delete Grid from space
      (mapc
         '((L) (mapc zap L))
         Grid )      
   )
)
(magic 5)



(msg 'ok)
(bye)
