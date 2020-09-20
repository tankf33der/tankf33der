(one N)
(setq R
   (catch 'boom
      (loop
         (let L (range 1 3)
            (when (=0 N)
               (let L (range 1 3)
                  (throw 'boom T) ) ) # 123 or any
            (dec 'N) ) ) ) )
(msg 'ok)
(bye)
