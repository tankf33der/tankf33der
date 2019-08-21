(load "@lib/simul.l")

(de d14 (Lst)
   (let
      (Lst (mapcar chop Lst)
         Grid (grid (length (car Lst)) (length Lst))
         C 0 )

      (mapc
         '((G L)
            (mapc
               '((This Val)
                  (and (= "#" Val) (=: V T)) )
               G
               L ) )
         Grid
         Lst )

      (for Col Grid
         (for This Col
            (when (=T (: V))
               (inc 'C)
               (recur (This)
                  (when (and This (=T (: V)))
                     (=: V 0)
                     (recurse (west This))
                     (recurse (east This))
                     (recurse (south This))
                     (recurse (north This)) ) ) ) ) )
      (for Col Grid
         (for This Col
            (prin (if (: V) @ ".")) )
         (prinl) )

      (println 'C C) ) )

(d14
   '("##.#.#.."
     ".#.#.#.."
     "....#..."
     "..#.##.."
     ".##.#..."
     "##..#..."
     ".#......"
     "##......" ) )

(msg 'ok)
(bye)
