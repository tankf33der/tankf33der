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
      )
      (with Center (=: V B))
      (println 'Center Center)
      (display Grid)
   )
)
(sandpile 5 4)

(msg 'ok)
(bye)
