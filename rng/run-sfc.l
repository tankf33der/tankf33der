## (cd /root/tankfeeder/rng/ ; pil ./run-sfc.l) | ./RNG_test stdin64
(load "sfc.l")

(de listN (N)
   (make
      (do 8
         (yoke (& `(hex "FF") N))
         (setq N (>> 8 N)) ) ) )
(off Sctx)
(sfc64_seed 'Sctx `(hex "123456"))
(loop
   (apply wr (listN (sfc64_raw 'Sctx))) )
