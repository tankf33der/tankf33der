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


(msg 'ok)
(bye)
