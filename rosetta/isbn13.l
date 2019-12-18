(de isbn13? (S)
   (let L
      (make
         (for N (chop S)
            (and (format N) (link @)) ) )
      (and
         (= 13 (length L))
         (=0 (% (sum * L (circ 1 3)) 10)) ) ) )
(println (isbn13? "978-1734314502"))
(println (isbn13? "978-1734314509"))
(println (isbn13? "978-1-86197-876-9"))
(println (isbn13? "978-2-74839-908-5"))
(println (isbn13? "978 1 86197 876 9"))
(msg 'ok)
(bye)
