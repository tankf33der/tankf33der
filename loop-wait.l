(unless (fork)
   (loop
      (println 'fork1)
      #(wait 1000) 
   ) 
)

(unless (fork)
   (loop
      (println 'fork2)
      (wait 2000) 
   ) 
)

(loop
   (println 'loop)
   (wait 3000) 
)
(wait)

(msg 'ok)
(bye)
