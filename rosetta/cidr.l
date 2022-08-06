(de cidr (Lst)
   (let N
      (&
         (sum >> (-24 -16 -8 0) Lst)
         (rev 32 (dec (** 2 (fin Lst)))) )
      (conc
         (mapcar
            '((A) (& (>> A N) 255))
            (24 16 8 0) )
         (fin Lst) ) ) )
(println
   (cidr (36 18 154 103 . 12)) )

(msg 'ok)
(bye)
