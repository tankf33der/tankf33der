(de az-AZ (N)
   (or
      (<= `(char "a") N `(char "z"))
      (<= `(char "A") N `(char "Z")) ) )
(de alpha? (S)
   (let S (chop S)
      (and
         (not (cdr S))
         (az-AZ (char (car S))) ) ) )
(test
   T
   (alpha? "a") )
(test
   T
   (=
      NIL
      (alpha? "1")
      (alpha? 1)
      (alpha? 123)
      (alpha? 'Mike)
      (alpha? "abc")
      (alpha? "АБВ")
      (alpha?) ) )

(msg 'ok)
(bye)

