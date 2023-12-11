# jan2018
# (c) Software Lab. Alexander Burger
# ulimit -s ulimited and GBs of RAM
(stack 3)
(for N 100000
   (co (intern (pack 'ring N))
      (let (N N  Send (intern (pack 'ring (if (= 100000 N) 1 (inc N)))))
         (for (I (yield)  (gt0 (yield (dec I) Send))  @)
            (at (0 . 10) (gc)) )
         N ) ) )
(println (yield 100010 'ring1))

(msg 'ok)
(bye)
