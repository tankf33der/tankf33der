(seed (in "/dev/urandom" (rd 8)))
(setq *D
   '((4 14 T) (9 31 T) (17 7) (20 38 T)
      (28 84 T) (40 59 T) (51 67 T) (54 34)
      (62 19) (63 81 T) (64 60) (71 91 T)
      (87 24) (93 73) (95 75) (99 78) ) )
(de players (N)
   (make
      (for I N
         (let P (pack "Player " I)
            (set P 1)
            (link P) ) ) ) )
(de turn (P)
   (let D (rand 1 6)
      (show P)
      (prin P " on square " (val P) ", rolls a " D)
      (if (> (+ (val P) D) 100)
         (prinl " but cannot move.")
         (set P (+ (val P) D))
         (prinl " and move to square " (val P) ".")

      )
   )
)

#{
(setq Ps (players 3))

(println 'Ps Ps)
(println (mapcar val Ps))
}#

(setq P (pack "Player" 1))
(set P 1)
(turn P)

(msg 'ok)
(bye)
