(de left ("N")
   (cond
      ((bit? 1 (val "N")) (inc "N" 2))
      ((== 2 (val "N")) (dec "N"))
      (T (dec "N" 2)) ) )
(de right ("N")
   (cond
      ((not (bit? 1 (val "N"))) (inc "N" 2))
      ((=1 (val "N")) (inc "N"))
      (T (dec "N" 2)) ) )

#{
(let (N 1  Key)
   (do 100
      (setq Key
         (pack 
            (make 
               (link (key))
               (while (key 8)
                  (link @) ) ) ) )
      (if (= Key "^[[D")
         (left 'N)
         (right 'N) )
      (println 'N N) ) )
}#

(de turing ()
   (let
      (Tape '(NIL)
         P 1
         State 'A
         Halt 'H
         D '(((A . 1) 1 R A) ((A . B) 1 S H))
         Curr
      )
      (set (enum 'Tape 1) 1)
      (set (enum 'Tape 2) 1)
      (set (enum 'Tape 4) 1)

      (loop
         (T (= State Halt))
         (setq Curr
            (cdr (assoc (cons State (val (enum 'Tape P))) D)) )
         (println 'Curr Curr)
         (wait 1000)
         (set (enum 'Tape P) (++ Curr))
         (case (++ Curr)
            (R (right 'P))
            (L (left 'P)) )
         (setq State (++ Curr))
         (println 'next 'P P 'State State)
         (wait 1000)
      )
   )
)


(turing)

(msg 'ok)
(bye)
