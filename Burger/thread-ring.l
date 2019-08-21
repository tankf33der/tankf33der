(for N 503  # Start all 503 coroutines
   (co (intern (pack 'ring N))
      (let (N N  Send (intern (pack 'ring (if (= 503 N) 1 (inc N)))))
         (for (I (yield)  (gt0 (yield (dec I) Send))  @))
         N ) ) )
(println (yield 5000000 'ring1))
(bye)


