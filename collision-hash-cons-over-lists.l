(gc 2048)
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make
      (do (rand 4 N)
         (link (rand 0 255)) ) ) )
(off D)
(zero C)
(do 1000000
   (let
      (L (sort (randL 7))
         K (cons (char (hash L)) L)
         R (idx 'D K))
      (ifn R
         (prog
            (set (car K) 1)
            (idx 'D K T) )
         (inc 'C)
         (inc (caar R)) ) ) )
(for L (idx 'D)
   (when (> (car (val L)) 3)
      (println 'L L (val (car L))) ) )
(println 'C C)
(println (length (idx D)))
(println (heap))

(msg 'ok)
(bye)

