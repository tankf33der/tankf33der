(seed (in "/dev/urandom" (rd 8)))

(unless (fork)
   (for N 5
      (println 'N N)
   )
)

(unless (fork)
   (loop
      (println 'third)
      (flush)
      (wait 2000)
   )
)

(wait)

(msg 'ok)

