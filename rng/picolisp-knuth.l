(seed (time))
(de rand4 NIL
   (make
      (do 4
         (yoke (rand 0 255)) ) ) )
(loop
   (apply wr (rand4)) )

