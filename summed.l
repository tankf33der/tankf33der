# warmup session
# adventofcode 2018, day 11, part 2
# https://en.wikipedia.org/wiki/Summed-area_table

(setq *D
   (31 2 4 33 5 36
      12 26 9 10 29 25
      13 17 21 22 20 18
      24 23 15 16 14 19
      30 8 28 27 11 7
      1 35 34 3 32 6 ) )
(de a11-grid (N)
   (make (do N (link (need N))) ) )
(de a11-get (X Y)
   (if (or (=0 X) (=0 Y))
      0
      (get G X Y) ) )
(de a11-set (X Y N)
   (set
      (nth G X Y)
      (-
         (+
            N
            (a11-get X (dec Y))
            (a11-get (dec X) Y) )
         (a11-get (dec X) (dec Y)) ) ) )
(de a11-print (Lst)
   (for L Lst
      (println L) ) )
(de a11-2 (N)
   (let (G (a11-grid N))
      (a11-print G)
      (for X N
         (for Y N
            (a11-set X Y (++ *D)) ) )
      (a11-print G) ) )
(a11-2 6)

(msg 'ok)
(bye)
