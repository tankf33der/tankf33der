(gc 512)
(load "@lib/simul.l")

(println (length (permute (chop "saule1234"))))
(println (length (uniq (permute (chop "saule1234")))))
(println (length (permute (chop "katsnius"))))
(println (length (uniq (permute (chop "katsnius")))))
(bye)



(let D NIL
   (in "latvian-dict.txt"
      (until (eof)
         (idx 'D (lowc (name (read))) T)
         (line) ) )
   # (println (idx 'D "saule"))

   (for L (uniq (permute (list 'k 'a 't 's 'n 'i 'u 's)))
   # (for L (permute (chop "saule"))
      (and
         (idx 'D (pack L))
         (println (pack L))
      )
   )

)



(msg 'ok)
(bye)
