(de dotimes ("N" . "Prg")
   (while (ge0 (dec '"N"))
      (run "Prg" 1) ) )
(let (A -1  "N" 0  Prg 777)
   (dotimes 5
      (inc 'A)
      (setq Prg (>> 1 Prg))
      (dec '"N") )
   (test
      T
      (bool
         (and
            (= A 4)
            (= "N" -5)
            (= Prg 24) ) ) ) )
(msg 'ok)
(bye)

