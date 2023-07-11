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
                     (=: G 0)
                     (inc 'Y) )
                  G L )
               (inc 'X) ) )
         Grid
         (apply mapcar (reverse Lst) list) )
      (for G Grid
         (for This G
            (=: H (mnhtn This End)) ) )
      (disp Grid 0
         '((This) (if (: Val) (pack " " @ " ") "   ")) )
      (until (== Curr End)
         (wait 3000)
         (with Curr
            (=: Visit T)
            (show Curr)
            (setq S
               (mini
                  '((Lst)
                     (with ((car Lst) This)
                        (+ (: G) (: H)) ) )
               (filter
                  '((Lst)
                     (with ((car Lst) This)
                        (and
                           (not (: Visit))
                           # (println 'This This (cdr Lst) Curr (get Curr 'G))
                           (=: G (+ (cdr Lst) (get Curr 'G)))
                           (show This)
                        )
                     )
                  )
                  (quote
                     (north . 1)
                     (south . 1)
                     (east . 1)
                     (west . 1)
                     (((X) (south (east X))) . 2)
                     (((X) (south (west X))) . 2)
                     (((X) (north (east X))) . 2)
                     (((X) (north (west X))) . 2) ) ) ) )
            (msg 'loop)
            (setq Curr ((car S) Curr))
            (println Curr End (== Curr End))
         )
      )
   )
) # let


(astar
   '("S  "
     " # "
     "  E" ) )

(msg 'ok)
(bye)
