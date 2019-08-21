## (cd /root/tankfeeder/rng/; pil ./run-jsf.l) | ./RNG_test stdin64
(load "jsf.l")

(off Jctx)
(jsf64_seed 'Jctx `(hex "123456"))
(loop
   (apply wr (jsf64_raw 'Jctx)) )
