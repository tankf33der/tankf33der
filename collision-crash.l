(seed (in "/dev/urandom" (rd 8)))
(off D)
(do 100
   (let
      (N (list (rand 0 255))
         K (cons (char (hash N)) N)
         R (idx 'D K) )
      (if R
         (inc (caar R))
         (prog
            (set (car K) 1)
            (idx 'D K T) )
      )

   )
)
(println
   (filter
      '((L) (> (val (car L)) 2))
      (idx 'D) ) )
(msg 'ok)
(bye)
