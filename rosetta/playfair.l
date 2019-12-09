(de 5x5 (L I?)
   (default I? 'I)
   (let L (conc (chop L) (chop "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
      (setq L (uniq (replace L "J" I?)))
      (make
         (while (cut 5 'L)
            (link @) ) ) ) )
(zero Z)
(for A 5
   (for B 5
      (for C 5
         (for D 5
            (unless (or (= A B) (= C D))
               (println A B C D)
               (inc 'Z)
            )
         )
      )
   )
)
(println 'Z Z)

(zero Z)
(for A 5
   (for B 5
      (unless (= A B)
         (inc 'Z)
      )
   )
)
(println 'Z Z)

(let Lst (5x5 "PLAYFAIREXAMPLE")
   (println Lst)
   (println (apply mapcar Lst list))

)




(msg 'ok)
(bye)
