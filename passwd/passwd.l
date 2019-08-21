#
# Parse passwd file, skip password
# and search by login or ID
#
(de assol (X Lst)
   (find
      '((L) (member X (head 2 L)))
      Lst ) )
(de passwd (F)
   (make
      (in F
         (until (eof)
            (link
               (make
                  (link (till ":" T))
                  (do 2
                     (from ":") )
                  (do 2
                     (link (format (till ":" T)))
                     (char) )
                  (do 3
                     (link (till ":^J^M" T))
                     (char) ) ) ) ) ) ) )
(setq *PSWD (passwd "passwd"))
(test
   (assol "www" *PSWD)
   (assol 67 *PSWD) )
(msg 'ok)
(bye)
