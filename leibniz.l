# https://github.com/vlang/v/issues/302
(scl 16)
(let (X 1.0  Pi 1.0)
   (for (I 2 (> 1000002 I) (inc I))
      (inc
         'Pi
         (/
            ((if (bit? 1 I) prog -) X)
            (dec (*/ 2.0 I 1.0)) ) ) )
   (setq Pi (*/ Pi 4.0 1.0))
   (test Pi 31415936535887964) )
(scl 0)
(msg 'OK-Leibniz)
