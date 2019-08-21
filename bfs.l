# FAILED, DONT USE

# in link:
# adventofcode 2018, day 15 and
# grid-warmup.l
# Breadth-first search warmup on counters

(load "@lib/simul.l")
(de file-read (F)
   (make (in F (while (line) (link @)))) )
(de grid-set (Lst Grid)
   (mapc
      '((G L)
         (mapc
            '((This Val)
               (case Val
                  ("#"
                     (with (: 0 1 1) (con (: 0 1)))    # W
                     (with (: 0 1 -1) (set (: 0 1)))   # E
                     (with (: 0 -1 1) (con (: 0 -1)))  # S
                     (with (: 0 -1 -1) (set (: 0 -1))) # N
                     (set This) )
                  (("E" "G")
                     (=: piece @)
                     (=: points 200) ) ) )
            G
            L ) )
      Grid
      (apply mapcar (reverse Lst) list) ) )
(de grid-remove (Grid)
   (for G Grid
      (for This G
         (set This) ) ) )
(de grid-display (Grid)
   (for G (flip (apply mapcar Grid list))
      (for This G
         (prin
            (cond
               ((not (val This)) "#")
               ((: mark) "!")
               ((: piece) (car @))
               (T ".") ) ) )
      (prinl) ) )
(de maze (This Goal)
   (let (Path NIL  Best NIL)
      (recur (This Path)
         (when (and This (not (: mark)) (not (: piece)))
            (push 'Path This)
            (if (== Goal This)
               (unless (and Best (>= (length Path) (length Best)))
                  (setq Best Path) )
               (=: mark T)
               (recurse (north This) Path)
               (recurse (west This) Path)
               (recurse (east This) Path)
               (recurse (south This) Path)
               (=: mark NIL) ) ) )
      Best ) )
(de bfs (This Goal)
   (let (Path 1  Best 0)
      (recur (This Path)
         (when (and This (not (: mark)) (not (: piece)))
            #(inc 'Path)
            (if (== Goal This)
               (unless (and (gt0 Best) (>= Path Best))
                  (setq Best Path) )
               (=: mark T)
               (grid-display Grid)
               (wait 50)
               (recurse (north This) (inc Path))
               (recurse (west This) (inc Path))
               (recurse (east This) (inc Path))
               (recurse (south This) (inc Path))
               (=: mark NIL) ) ) )
      Best ) )
(de mike (F)
   (let
      (Lst (file-read F)
         Grid (grid (length (car Lst)) (length Lst))
      )
      (grid-set Lst Grid)
      (grid-display Grid)
      (println (bench (maze 'c2 'd4)))
      (println (bench (bfs 'c2 'd4)))

      # Fin
      (grid-remove Grid)
   )
)
(mike "advent2018/data/15-test-4.txt")
#(mike "advent2018/data/15-short.txt")

(msg 'ok)
(bye)

