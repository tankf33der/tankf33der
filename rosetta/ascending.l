(de ascending2 (N)
   (let (D 2  L (1 2 2 . (4 2 4 2 4 6 2 6 .))  C 0)
      (make
         (while (> N C)
            (and
               (apply < (chop D))
               (link D)
               (inc 'C) )
            (inc 'D (++ L))
         )
      )
   )
)
(de asc (N)
   (let (D 2  L (1 2 2 . (4 2 4 2 4 6 2 6 .)))
      (do 16
         (printsp (pop 'L))

      )
   )
)


# (println (ascending 100))
(println (asc 100))


(msg 'ok)
(bye)
