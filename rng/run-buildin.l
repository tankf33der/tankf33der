## (cd /root/tankfeeder/rng/ ; pil ./run-buildin.l) | ./RNG_test stdin32
## (cd /root/tankfeeder/rng/ ; pil ./run-buildin.l) | ./RNG_test stdin32 -tf 2 -te 1

(seed (time))
(de listN (N)
   (make
      (do 4
         (yoke (& `(hex "FF") N))
         (setq N (>> 8 N)) ) ) )
(loop
   (apply wr (listN (rand 0 4294967295))) )

