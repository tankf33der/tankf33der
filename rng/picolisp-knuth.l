(seed (in "/dev/urandom" (rd 8)))
(de enc NIL
   (let N (rand 0 `(hex "7FFFFFFF"))
      (make
         (do 4
            (link (& 255 N))
            (setq N (>> 8 N)) ) ) ) )
#(sigio 1 '(bye))
(out NIL
   (loop
      (apply wr (enc)) ) )
