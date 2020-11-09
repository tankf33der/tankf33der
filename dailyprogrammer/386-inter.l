# https://www.reddit.com/r/dailyprogrammer/comments/jfcuz5/20201021_challenge_386_intermediate_partition/
# Euler's pentagonal formula
(de partitions (N)
   (let (O 0  G 1  R 0  Flg)
      (do N
         (if Flg
            (setq
               R (+ R G)
               G (+ G 2)
            )
            (setq
               R (+ R O)
               O (+ O 1) )
         )
         (onOff Flg)
      )
      R
   )
)

(println (partitions 1))
(println (partitions 2))
(println (partitions 3))
(println (partitions 4))
(println (partitions 5))
(println (partitions 7))
(println (partitions 8))
(println (partitions 9))
(println (partitions 10))
(println (partitions 11))
(println (partitions 12))
(println (partitions 13))
(println (partitions 14))
(println (partitions 15))

#{
(println (partitions 66))

(let R 1
   (for N 66
      (println (partitions N))
   )
   (println 'R R)
)
}#




(msg 'ok)
(bye)
