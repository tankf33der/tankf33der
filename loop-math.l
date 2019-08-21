(scl 16)
(let X 44.0
   (do 10
      (setq X
         (+ 1.4455 (*/ X -1.99 1.0)) )
      (println (format X *Scl)) ) )
(msg 'ok)
(bye)
