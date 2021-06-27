(de un (Lst)
   (let (N (length Lst)  D)
      (mapc
         '((Lst)
            (mapc
               '((L) (accu 'D L 1))
               Lst ) )
         (mapcar chop Lst) )
      (by
         cdr
         sort
         (filter '((L) (== N (cdr L))) D)
      )
   )
)
(println
   (un
      (quote
         "1a3c52debeffd"
         "2b6178c97a938stf"
         "3ycxdb1fgxa2yz" ) ) )
(msg 'ok)
(bye)
