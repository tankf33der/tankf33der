(seed (in "/dev/urandom" (rd 8)))
(de rand8 NIL
   (make
      (do 8
         (link (rand 0 255)) ) ) )
(out NIL
   (loop
      (apply wr (rand8)) ) )
