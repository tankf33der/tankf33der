# 27oct12 Software Lab. Alexander Burger
# Use: time bin/picolisp misc/bench.l

(de fibo (N)
   (if (>= 2 N)
      1
      (+ (fibo (dec N)) (fibo (- N 2))) ) )

(println (fibo 36))
(bye)
