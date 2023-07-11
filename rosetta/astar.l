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
         Curr NIL
         End NIL
      )
      (mapc
         '((G L)
            (let Y 1
               (mapc
                  '((This V)
                     (cond
                        ((= "S" V) (setq Curr This) (=: Val V))
                        ((= "E" V) (setq End This) (=: Val V)) )
                     (cond
                        ((= "#" V)
                           (with (: 0 1 1) (con (: 0 1)))    # Cut off west
                           (with (: 0 1 -1) (set (: 0 1)))   # east
                           (with (: 0 -1 1) (con (: 0 -1)))  # south
                           (with (: 0 -1 -1) (set (: 0 -1))) # north
                           (set This) )
                        (T (=: Val V)) )
                     (=: X X)
                     (=: Y Y)
                     (inc 'Y) )
                  G L )
               (inc 'X) ) )
         Grid
         (apply mapcar (reverse Lst) list) )
      (for G Grid
         (for This G
            (=: Mnhtn (mnhtn This E)) ) )
      (disp Grid 0
         '((This) (if (: Val) (pack " " @ " ") "   ")) )
      (with Curr
         (=: Visit T)
         (println
            (filter
               '((Dir)
                  (println Lst 'car (car Lst) 'cdr (cdr Lst))
                  (with ((car Dir) This)
                     (println 'This This)
                  )
                  # (let? This ((car Lst) Curr)
                     # (println 'inside This)
                     # (and
                        # (not (: Visit)) )
                  # )

               )
               (quote
                  (north . 1)
                  (south . 1)
                  (east . 1)
                  (west . 1)
                  (((X) (south (east X))) . 2)
               )
         )
      )

   ) # let
)

(astar
   '("S  "
     "   "
     "  E" ) )

(msg 'ok)
(bye)
