# (in "small.csv"
#    (until (eof)
#       (skip "#")
#       (let (A (prog1 (till ";" T) (char))  B (format (line T) 4))
#          (if (setq Z (lup R A))
#             (let (B1 (get Z 2)  D1 (get Z 4))
#                (when (< B B1) (set (cdr Z) B))
#                (when (> B B1) (set (cdddr Z) B))
#                (inc (caddr Z) B)
#                (inc (cdaddr Z)) )
#             (idx 'R (list A B (list B 1) B) T) ) ) ) )

(off R)
(in "weather_stations.csv"
   (until (eof)
      (skip "#")
      (let (A (prog1 (till ";" T) (char))  B (format (line T) 4))
         (ifn (idx 'R A T)
            (set A (list 1 B B B))
            (let Lst (val (car @))
               (inc Lst)
               (when (< B (get Lst 2)) (put Lst 2 B))
               (when (> B (get Lst 4)) (put Lst 4 B))
               (put Lst 3 (+ B (get Lst 3)))
               (println 'fin A Lst)

                ) ) ) ) )
(when (idx 'R "Delhi")
   (println (val @)) )



(msg 'ok)
(bye)
