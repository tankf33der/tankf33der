(in "whirlpool-sbox.dat"
   (until (eof)
      (mapc
         printsp
         (mapcar '((N) (hex (sym N))) (str (line T))))
      (prinl) ) )

(bye)
