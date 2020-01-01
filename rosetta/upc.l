(de l2n (Lst)
   (case Lst
      ((0 0 0 1 1 0 1) 0)
      ((0 0 1 1 0 0 1) 1)
      ((0 0 1 0 0 1 1) 2)
      ((0 1 1 1 1 0 1) 3)
      ((0 1 0 0 0 1 1) 4)
      ((0 1 1 0 0 0 1) 5)
      ((0 1 0 1 1 1 1) 6)
      ((0 1 1 1 0 1 1) 7)
      ((0 1 1 0 1 1 1) 8)
      ((0 0 0 1 0 1 1) 9) ) )
(de convs (Lst Flg)
   (make
      (for L Lst
         (link
            (if2 (= "#" L) Flg 0 1 1 0) ) ) ) )
(de parse (Str)
   (let Lst (clip (chop Str))
      (make
         (cut 3 'Lst)
         (link (convs (cut 7 'Lst)))
         (link (convs (cut 7 'Lst)))
         (link (convs (cut 7 'Lst)))
         (link (convs (cut 7 'Lst)))
         (link (convs (cut 7 'Lst)))
         (link (convs (cut 7 'Lst)))
         (cut 5 'Lst)
         (link (convs (cut 7 'Lst) T))
         (link (convs (cut 7 'Lst) T))
         (link (convs (cut 7 'Lst) T))
         (link (convs (cut 7 'Lst) T))
         (link (convs (cut 7 'Lst) T))
         (link (convs (cut 7 'Lst) T))
      )
   )
)


(println
   (mapcar
      l2n
      (parse "         # #   # ##  #  ## #   ## ### ## ### ## #### # # # ## ##  #   #  ##  ## ###  # ##  ## ### #  # #       ")
   )
)

(msg 'ok)
(bye)
