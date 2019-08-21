(in "parse-hex.dat"
   (until (eof)
      (println
         (mapcar
            '((N) (hex (sym N)))
            (str (line T))) ) ) )
(bye)
