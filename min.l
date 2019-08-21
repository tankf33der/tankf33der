(de minimum (L)
   (let (Pos 1  Min (car L))
      (for (I . X) L
         (and
            (< X Min)
            (setq Pos I) ) )
      Pos ) )
(println
   (minimum (3 2 7 1 4 8)) )


