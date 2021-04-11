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
         (set (enum 'Tape P) (++ Curr))
         ((++ Curr) 'P)
         (setq State (++ Curr)) )
      C ) )
      
# Incrementer
(set
   'Incr '(NIL)
   (enum 'Incr 1) 1
   (enum 'Incr 2) 1
   (enum 'Incr 4) 1 )
(test
   4
   (turing
      Incr
      'A
      'H
      '(((A . 1) 1 right A)
         ((A . 0) 1 prog H)) ) )

# Three-state busy beaver
(test 
   13
   (turing
      '(NIL)
      'A
      'H
      '(((A . 0) 1 right B)
         ((A . 1) 1 left C)
         ((B . 0) 1 left A)
         ((B . 1) 1 right B)
         ((C . 0) 1 left B)
         ((C . 1) 1 prog H) ) ) )

# Five-state busy beaver
(test
   47176870
   (turing
      '(NIL)
      'A
      'H
      '(((A . 0) 1 right B)
         ((A . 1) 1 left C)
         ((B . 0) 1 right C)
         ((B . 1) 1 right B)
         ((C . 0) 1 right D)
         ((C . 1) 0 left E)
         ((D . 0) 1 left A)
         ((D . 1) 1 left D)
         ((E . 0) 1 prog H)
         ((E . 1) 0 left A) ) ) )
(msg 'ok)
(bye)
