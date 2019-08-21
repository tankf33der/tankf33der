(seed (in "/dev/urandom" (rd 8)))
(load "@lib/simul.l")
 
(de maze (DX DY)
   (let Maze (grid DX DY)
      (let Fld (get Maze (rand 1 DX) (rand 1 DY))
         (recur (Fld)
            (for Dir (shuffle '((west . east) (east . west) (south . north) (north . south)))
               (with ((car Dir) Fld)
                  (unless (or (: west) (: east) (: south) (: north))
                     (put Fld (car Dir) This)
                     (put This (cdr Dir) Fld)
                     (recurse This) ) ) ) ) )
      (for (X . Col) Maze
         (for (Y . This) Col
            (set This
               (cons
                  (cons
                     (: west)
                     (or
                        (: east)
                        (and (= Y 1) (= X DX)) ) )
                  (cons
                     (: south)
                     (or
                        (: north)
                        (and (= X 1) (= Y DY)) ) ) ) ) ) )
      Maze ) )
(de shortestPath (Goal This Maze)
   (let (Path NIL  Best NIL  Dir " > ")
      (recur (This Path Dir)
         (when (and This (not (: mark)))
            (push 'Path (cons This Dir))
            (if (== Goal This)
               (unless (and Best (>= (length Path) (length Best)))
                  (setq Best Path) )
               (=: mark T)
               (recurse (: west) Path " > ")
               (recurse (: east) Path " < ")
               (recurse (: south) Path " \^ ")
               (recurse (: north) Path " v ")
               (=: mark NIL) ) ) )
      (disp Maze 0
         '((Fld) (if (asoq Fld Best) (cdr @) "   ")) ) ) )
(de display (Maze)
   (disp Maze 0 '((This) "   ")) )

# work
(display (maze 11 8))
(shortestPath 'a8 'k1 (maze 11 8))

(msg 'ok)
(bye)
