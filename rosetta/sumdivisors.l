(de propdiv (N)
   (let S 0
      (for X N
         (and (=0 (% N X)) (inc 'S X)) )
      S ) )
(let
   (L (mapcar propdiv (range 1 100))
      Fmt (need 10 5) )
   (while (cut 10 'L)
      (tab Fmt @) ) )


(msg 'ok)
(bye)
