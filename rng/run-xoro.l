# (cd /root/tankfeeder/rng/ ; pil ./run-xoro.l) | ./RNG_test stdin64
(load "xoroshiro128+.l")

(de listN (N)
   (make
      (do 8
         (yoke (& `(hex "FF") N))
         (setq N (>> 8 N)) ) ) )
(loop
   (apply wr (listN (xoronext))) )
