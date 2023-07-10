# https://rosettacode.org/wiki/A*_search_algorithm
(load "@lib/simul.l")
(symbols 'pico 'simul)
(de mnhtn (A B)
   (+
      (abs (- (; A X) (; B X)))
      (abs (- (; A Y) (; B Y))) ) )
(de astar (Lst)
   (let
      (Lst (mapcar chop Lst)
         Grid (grid (length (car Lst)) (length Lst))
         X 1
      )
      (mapc
         '((G L)
            (let Y 1
               (mapc
                  '((This V)
                     (cond
                        ((= "#" V)
                           (with (: 0 1 1) (con (: 0 1)))    # Cut off west
                           (with (: 0 1 -1) (set (: 0 1)))   # east
                           (with (: 0 -1 1) (con (: 0 -1)))  # south
                           (with (: 0 -1 -1) (set (: 0 -1))) # north
                           (set This) )
                        (T (=: V V)) )
                     (=: X X)
                     (=: Y Y)
                     (inc 'Y) )
                  G L )
               (inc 'X) ) )
         Grid
         (apply mapcar (reverse Lst) list) )
      (disp Grid 0
         '((This) (if (: V) (pack " " @ " ") "   ")) )
   )
)

(astar
   '("S  "
     " # "
     "  E" ) )

(msg 'ok)
(bye)
