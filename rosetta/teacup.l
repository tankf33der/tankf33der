(de rotw (W)
   (let W (chop W)
      (make
         (do (length W)
            (link (pack (copy W)))
            (rot W) ) ) ) )
(setq Words
   (make
      (in "../wordlist.10000"
      #(in "../teacup.txt"
         (while (line T)
            (link @) ) ) ) )
(off D)
(mapc
   '((W)
      (idx 'D (cons (hash W) W) T) )
   Words )
#(println D)

(println
(extract
   '((W)
      (when (>= (length W) 3)
         # XXX (let? ...)
         (let Lst (rotw W)
            (when
               (fully
                  '((L)
                     #(println 'W W 'Lst Lst 'L L)
                     #(wait 100)
                     (idx 'D (cons (hash L) L)))
                  Lst )
               #(println 'found)
               Lst
            )
         )
      )
   )
   Words
)
)


(msg 'ok)
(bye)
