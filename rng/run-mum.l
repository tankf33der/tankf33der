## (cd /root/tankfeeder/rng/ ; pil ./run-mum.l) | ./RNG_test stdin64
(load "mum.l")

(de listN (N)
   (make
      (do 8
         (yoke (& `(hex "FF") N))
         (setq N (>> 8 N)) ) ) )

(mum-start)
(loop
   (apply wr (listN (mum-next))) )

