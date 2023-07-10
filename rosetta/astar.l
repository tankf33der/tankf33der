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
      (mapc
         '((G L)
            (mapc
               '((This Val)
                  (println This Val)
                  (cond
                     ((= "#" Val)
                        (with (: 0 1 1) (con (: 0 1)))    # Cut off west
                        (with (: 0 1 -1) (set (: 0 1)))   # east
                        (with (: 0 -1 1) (con (: 0 -1)))  # south
                        (with (: 0 -1 -1) (set (: 0 -1))) # north
                        (set This) )
                     (T (=: val Val)) )
               )
               G L ) )
         Grid
         (apply mapcar (reverse Lst) list) )
      (disp Grid 0
         '((This) (if (: val) (pack " " @ " ") "   ")) )
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
