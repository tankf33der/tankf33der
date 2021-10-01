(de numbers (N)
   (let (P 10  Q N)
      (make
         (until (> 10 Q)
            (link
               (+
                  (setq Q (/ N P))
                  (% N P) ) )
            (setq P (* P 10)) ) ) ) )
(println (numbers 6425))
(println (numbers 12345))

(msg 'ok)
(bye)
