(off R)

(zero C)
(for A (range -1000 1000)
   (for B (range -300 300)
      (inc 'C)
      (let (X (cons A B)  K (cons (char (hash X)) X))
         (if (idx 'R K)
            (prog
               (println A B)
               (quit) )
            (idx 'R K T) ) ) ) )
(println (length (idx 'R)))
(println 'C C)
(msg 'ok)
(bye)

