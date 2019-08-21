(setq S (need 4))
(println 'S S)
(map
   '((L D) (set L (x| (rand 0 255) (car D))))
   S
   (12 3 4 4) )
(println 'S S)
(msg 'ok)
(bye)

