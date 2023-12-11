(seed (in "/dev/urandom" (rd 8)))
(load "@lib/simul.l")
(symbols 'simul 'pico)
(stack 2)
(for A 10
   (let N 500000
      (for B N
         (co (pack 'a B)
            (yield 'ready) ) )
      (for X (shuffle (cdr (rot (stack))))
         (co (car X)) )
      (println 'A A)
      (gc 0) ) )
(msg 'ok)
(bye)
