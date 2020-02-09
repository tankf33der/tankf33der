(off R)

(for A (range -10000 10000)
   (for B (range -10000 10000)
      (let K (char (hash (cons A B)))
         (set K (cons A B))
         (if (idx 'R K)
            (println A B (val (car @)))
            (idx 'R K T) ) ) ) )
(msg 'ok)
(bye)

