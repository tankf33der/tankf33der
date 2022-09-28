(seed (in "/dev/urandom" (rd 8)))
(out NIL
   (loop
      (wr (rand 0 255)) ) )
