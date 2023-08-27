(de qsieve (F)
   (make
      (in F
         (while (read "_")
            (let R @
               (link R)
               (when (= "\^" (peek))
                  (read "_")
                  (do (dec (read "_"))
                     (link R) ) )
                  (read "_") ) ) ) ) )
(test
   (2 2 3 3 3 1234 123456)
   (qsieve "qsieve.txt") )
(msg 'ok)
(bye)
