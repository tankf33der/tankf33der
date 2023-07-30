# https://rosettacode.org/wiki/Abelian_sandpile_model
(load "@lib/simul.l")
(symbols 'pico 'simul)
(de display (Grid)
  (disp Grid 0
      '((This) (if (: V) (pack " " @ " ") "   ")) ) )
(de sandpile (A B)
   (let
      (Grid (grid A A)
         Size (/ (inc A) 2)
         Center (get Grid Size Size)
         Done NIL
      )
      (for G Grid
         (for This G
            (=: V 0) ) )
      (with Center
         (=: V B)
         (for G Grid
            (for This G
               (when (>= (: V) 4)
                  (=: V (- (: V) 4))
                  (mapc
                     '((Dir)
                        (with (Dir This)
                           (=: V (inc (: V)))
                        )
                     )
                     '(north south west east)
                  )
               )
            )
         )
         # (mapc
            # '((Dir)
               # (with (Dir This)
                  # (println 'This Dir This)
               # )
            # )
            # '(north south west east)
         # )
      )
      # (println 'Center Center)
      (display Grid)
   )
)
(sandpile 5 4)

(msg 'ok)
(bye)
