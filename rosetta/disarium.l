
(de disarium (N)
   (let S 0
      (for (I . N) (mapcar format (chop N))
         (inc 'S (** N I)) )
      (= N S) ) )
(let (N 0  C 0)
   (until (= C 19)
      (and
         (disarium N)
         (printsp N)
         (inc 'C) )
      (inc 'N) ) )
(msg 'ok)
(bye)
