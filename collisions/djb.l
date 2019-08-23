(de djb (L)
   (let H 5381
      (for N L
         (setq H (+ N (* 33 H))) )
      (& H `(hex "FFFFFFFF")) ) )
(msg 'ok)
(bye)
