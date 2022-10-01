(seed (time))
(de rand8 NIL
   (make
      (do 8
         (link (rand 0 255)) ) ) )
(loop
   (apply wr (rand8)) )
