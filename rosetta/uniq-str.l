(de a (V K N)
   (if (assoc K (val V))
      (push (cdr @) N)
      (push V (list K (list N))) ) )
(de un (Lst)
   (let (N (length Lst)  D)
      (for (I . Lst) (mapcar chop Lst)
         (for L Lst
            (a 'D L I) ) )
      (filter
         '((L)
            (let L (cadr L)
               (println 'L L)
               (and (cddr L) (caddr L))
            ) )
         D )
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
