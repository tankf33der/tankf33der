(unless (fork)
   (loop
      (println (- (time) (swap (0) (time))) (inc (0)))
      (wait 2000) ) )
(unless (fork)
   (loop
      (wait 200)
      (tell '+ 3 4) ) )
(wait)

