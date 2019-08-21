(de zipp (Lst)
   (let (Flg NIL  R1 NIL  R2 NIL)
      (for N Lst
         (queue (if (onOff Flg) 'R1 'R2) N) )
      (println 'R1 R1 'R2 R2)
      (append R1 R2) ) )
(println (zipp (range 1 10)))

(msg 'ok)
(bye)

