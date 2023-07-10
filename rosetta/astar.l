# https://rosettacode.org/wiki/A*_search_algorithm
(load "@lib/simul.l")

(symbols 'pico 'simul)

(setq G (grid 3 5))
(println 'G G)

(de astar (Lst)
   (let
      (Lst (mapcar chop Lst)
         Grid (grid (length (car Lst)) (length Lst))
      )
   )
)

(with 'a1 (=: X 12))

(show 'a1)

(astar
   '("S  "
     " # "
     "  E" ) )

(msg 'ok)
(bye)
