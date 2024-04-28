(de Mybench Prg
   (let U (usec)
      (prog1
         (run Prg 1)
         (out 2
            (prinl
               "XXX:"
               C
               " "
               (format (*/ (- (usec) U) 1000) 3) ) ) ) ) )

(let C 1234
   (Mybench (wait 11000))
)
(msg 'ok)
(bye)
