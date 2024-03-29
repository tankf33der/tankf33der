# https://rosettacode.org/wiki/A*_search_algorithm
(load "@lib/simul.l")
(symbols 'simul 'pico)
(de mnhtn (A B)
   (+
      (abs (- (; A X) (; B X)))
      (abs (- (; A Y) (; B Y))) ) )
(de zap-grid (Grid)
   (for G Grid
      (for This G
         (zap This) ) ) )
(de display (Grid)
  (disp Grid 0
      '((This) (if (: Val) (pack " " @ " ") "   ")) ) )
(de create-mnhtn (Grid)
  (for G Grid
      (for This G
         (=: H (mnhtn This End)) ) ) )
(de make-move (A B)
   (put A 'Val ".")
   (put B 'Val "C") )
(de create-grid (Grid Lst)
   (mapc
      '((G L)
         (let Y 1
            (mapc
               '((This V)
                  (cond
                     ((= "C" V) (setq Curr This) (=: Val V))
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
      (apply mapcar (reverse Lst) list) ) )
(de astar (Lst)
   (let
      (Lst (mapcar chop Lst)
         Grid (grid (length (car Lst)) (length Lst))
         X 1
         Curr NIL
         End NIL
      )
      (create-grid Grid Lst)
      (create-mnhtn Grid)
      (display Grid)
      (make-move 'a3 'a1)
      (display Grid)

      (zap-grid Grid)
   )
) # let


(astar
   '("C.."
     ".#E"
     "..." ) )

(msg 'ok)
(bye)
