#{
   $ convert -size 1920x1080 -depth 1 random.txt random.bmp
   $ identify random.bmp
   random.bmp BMP 1920x1080 1920x1080+0+0 8-bit DirectClass 6.221MB 0.060u 0:00.059 
}#


(seed (in "/dev/random" (rd 8)))
(out "random.txt"
   (println 'P1)
   (println '1920 '1080)
   (do (* 1920 1080)
      (println (rand 0 1)) ) )
(bye)
