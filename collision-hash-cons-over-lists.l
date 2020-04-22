(gc 128)
(seed (in "/dev/urandom" (rd 8)))
(de randL NIL
   (make
      (do 1
         (link (rand 0 255)) ) ) )
(off D)
(zero C)
(do 100
   (let (L (randL)  K (cons (char (hash L)) L)  R (idx 'D K))
      #(println 'L L 'K K)
      (ifn R
         (prog
            (set (car K) 1)
            (idx 'D K T)
         )
         (inc 'C)
         #(println 'L L 'K K)
         (inc (caar R))
      )
   )
)

#{
(for L (idx 'D)
   #(wait 100)
   (println 'L L (val (car L)))
)
}#

   (filter
      '((L)
         (and
            (> (val (car L)) 1)
            (println 'L L (val (car L)) (cdr L))
         )
      )
      (idx 'D) )


(println 'C C)
(println (length (idx 'D)))

(msg 'ok)
(bye)

