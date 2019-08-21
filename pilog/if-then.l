(be gt0 (@N @R)
   (^ @ (gt0 (-> @N)))
   T
   (^ @R 'yes) ) 
(be gt0 (@N @R)
   (^ @R 'no) )

(test
   '(((@R . yes)))
   (solve '((gt0 12 @R))) )
  
(msg 'ok)
(bye) 
