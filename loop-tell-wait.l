(unless (fork)
   (loop
      (tell '+ 3 4) ) )
(unless (fork)
   (loop
      (println (inc (0)))
      (wait 2000) ) )
(wait)
