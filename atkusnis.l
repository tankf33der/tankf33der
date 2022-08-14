(gc 128)
(load "@lib/simul.l")
(let D NIL
   (in "latvian-dict.txt"
      (until (eof)
         (idx 'D (lowc (till "^I")) T)
         (from "\n") ) )
   (for L (uniq (permute (chop "katsnius")))
      (and
         (idx 'D (pack L))
         (println (pack L)) ) ) )
(msg 'ok)
(bye)
