(de qsieve (F)
   (make
      (in F
         (while (setq @@ (read "_"))
            (link @@)
            (ifn (= "\^" (peek))
               (read "_")
               (read "_")
               (do (dec (read "_"))
                  (link @@) )
               (read "_") ) ) ) ) )
(println (qsieve "qsieve.txt"))
(msg 'ok)
(bye)
