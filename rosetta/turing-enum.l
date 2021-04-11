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
(de turing (Tape State Halt D)
   (let
      (C 0  P 1  Curr)
      (loop
         (T (= State Halt))
         (inc 'C)
         (setq Curr
            (cdr
               (assoc
                  (cons
                     State
                     (if (val (enum? Tape P)) @ 0) )
                  D ) ) )
         # (println 'State State 'P P 'if (if (val (enum? Tape P)) @ 0))
         # (println 'assoc (assoc (cons State (if (val (enum? Tape P)) @ 0)) D))
         # (println
            # 'Curr
            # (assoc (cons State (if (val (enum? Tape P)) @ 0)) D)
            # 'P P
            # 'State State )
         # (wait 1000)
         (set (enum 'Tape P) (++ Curr))
         (case (++ Curr)
            (R (right 'P))
            (L (left 'P)) )
         (setq State (++ Curr)) )
      C ) )
# Incrementer
(set
   'Incr '(NIL)
   (enum 'Incr 1) 1
   (enum 'Incr 2) 1
   (enum 'Incr 4) 1 )
(test
   5
   (turing
      Incr
      'A
      'H
      '(((A . 1) 1 R A) ((A . 0) 1 S H)) ) )
# Three-state busy beaver
(test
   14
   (turing
      '(NIL)
      'A
      'H
      '(((A . 0) 1 R B)
         ((A . 1) 1 L C)
         ((B . 0) 1 L A)
         ((B . 1) 1 R B)
         ((C . 0) 1 L B)
         ((C . 1) 1 S H) ) ) )
# Five-state busy beaver
(println
(turing
   '(NIL)
   'A
   'H
   '(((A . 0) 1 R B)
     ((A . 1) 1 L C)
     ((B . 0)     1 R C)
     ((B . 1) 1 R B)
     ((C . 0)     1 R D)
     ((C . 1) 0 L E)
     ((D . 0)     1 L A)
     ((D . 1) 1 L D)
     ((E . 0)     1 S H)
     ((E . 1) 0 L A) ) )
)
(msg 'ok)
(bye)
