(in "tiger-sbox.dat"
   (let Fmt (6 -21 -1)
      (until (eof)
         (and
            (mapcar
               '((S) (hex (pack (tail -2 (chop S)))))
               (str (line T)))
            (tab Fmt "      " (car @) (cadr @)) ) 
         ) ) )
(bye)
