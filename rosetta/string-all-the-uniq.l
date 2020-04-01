(de uniq? (Str)
   (let
      (P 0
         Lst
         (by
            '((A)
               (put A 'P (inc 'P))
               (set A (char A)) )
            group
            (chop Str) )
      )
      (println 'Lst Lst)
      (println 'mini
         (mini
            '((L)
               (println 'L 'L (mapcar '((A) (get A 'P)) L) (cdr L))
               (nand
                  (cdr L)
                  (mini '((A) (get A 'P)) L)
                  @@ )
            )
            Lst ) )
      (println '@@ @@)
   )
)
(uniq? "aaamikem")

(msg 'ok)
(bye)

