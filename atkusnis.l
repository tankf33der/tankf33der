(gc 512)
(load "@lib/simul.l")

(let D NIL
   (in "latvian-dict.txt"
      (until (eof)
         (idx 'D (lowc (name (read))) T)
         (line) ) )
   (for L (uniq (permute (chop "katsnius")))
      (and
         (idx 'D (pack L))
         (println (pack L)) ) ) )
(msg 'ok)
(bye)