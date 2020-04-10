

(de rotn (A)
   (let A (chop A)
      (make
         (do (length A)
            (link (rot (copy A))) ) ) ) )
(de necklace (A B)
   (let (A (rotn A)  B (chop B))
      (println
      (pick
         '((C) (= C B))
         (car A)
       ))
   )
)

(necklace "nicole" "icolen")

(msg 'ok)
(bye)

