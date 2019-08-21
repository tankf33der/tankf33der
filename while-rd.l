(println '@@ @@)
(in "while-rd.dat"
   (while
      (and
         (setq L
            (make
               (do 8
                  (NIL (setq @@ (rd 1)))
                  (link @@) ) ) )
         (= 8 (length L)) )
          
      (println 'L L)
   )
   (println 'end (length L) L)
)
(msg 'ok)
(bye)
