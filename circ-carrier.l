(seed (in "/dev/urandom" (rd 8)))

(setq L (range 1 5) Len (length L))
(setq I 1)

(de right (NIL)
   (inc 'I)
   (setq I (inc (% (dec I) Len)))
)

(de left (NIL)
   (dec 'I)
   (and
      (ge0 I)
      (inc 'I Len) )
   (setq I (inc (% (dec I) Len)))
)


(do 16
   (right)
   (println 'I I)
)

(msg 'ok)
(bye)
