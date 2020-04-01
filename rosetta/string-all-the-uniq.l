(de burn (Lst)
   (by
      '((A)
         (put A 'P (inc 'P))
         (set A (char A)) )
      group
      Lst ) )
(de first (Lst)
   (mini
      '((L)
         (nand
            (cdr L)
            (apply
               min
               (mapcar '((A) (get A 'P)) L) ) ) )
      Lst ) )
(de uniq? (Str)
   (let (P 0  Lst (burn (chop Str))  M (first Lst))
      (println 'mini M)
      (println (apply min (mapcar '((A) (get A 'P)) M)))
   )
)
(pp 'uniq?)
(uniq? "aaamikem")

(msg 'ok)
(bye)

