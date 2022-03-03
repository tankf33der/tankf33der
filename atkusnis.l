(gc 384)
(load "@lib/simul.l")

(let D NIL
   (in "entries.txt"
      (until (eof)
         (idx 'D (lowc (name (read))) T)
         (line) ) )
   # (println (idx 'D "saule"))

   (for L (permute (list 'k 'a 't 's 'n 'i 'u 's))
      (and
         (idx 'D (pack L))
         (println (pack L))
      )
   )


)


# (mapc
   # '((A)
      # (let L (pack A)
         # (and
            # (member A W)
            # (println L)
         # )
      # )
   # )
   # (permute (list 'k 'a 't 's 'n 'i 'u 's)))

(msg 'ok)
(bye)
