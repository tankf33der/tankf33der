(de Mybench Prg
   (let U (usec)
      (prog1
         (run Prg 1)
         (out 2
            (prinl
               "XXX:"
               *Count
               " "
               (format (*/ (- (usec) U) 1000) 3) ) ) ) ) )
(let *Count 1234
   (Mybench (wait 1234)) )
(msg 'ok)
(bye)
