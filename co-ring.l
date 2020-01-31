`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))

# warmup AoC 2019, day 7, part 2
# ring of 5 wagons on coroutines.
(de wagon (N)
   (co (intern (pack 'i7 N))
      (let
         (N N
            Got 0
            Send (intern (pack 'i7 (if (= 3 N) 1 (inc N))))
            Rnd (rand 1 10)
            C 0
         )
         (setq Got (yield))
         (loop
            (inc 'C)
            (T (>= C 7) 123)
            (println 'loop N 'Rnd Rnd 'Got Got 'C C)
            (yield
               (inc 'Rnd Got)
               Send )
         )
      )
   )
)
(wagon 1 10)
(wagon 2 20)
(wagon 3 30)
(setq R (yield 10 'i71))
(println 'R R)

(msg 'fin)
(bye)

