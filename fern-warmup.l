`(== 64 64)
(scl 20)
(de gridX (X)
   (format
      (round
         (+ 320.0 (*/ X 58.18 1.0)) ) ) )
(de gridY (Y)
   (format
      (round
         (- 640.0 (*/ Y 58.18 1.0))) ) )
(de calc (R X Y)
   (cond
      ((< R 1) (list 0 (*/ Y 0.16 1.0)))
      ((< R 86)
         (list
            (+ (*/ 0.85 X 1.0) (*/ 0.04 Y 1.0))
            (+ (*/ -0.04 X 1.0) (*/ 0.85 Y 1.0) 1.6) ) )
      ((< R 93)
         (list
            (- (*/ 0.2 X 1.0) (*/ 0.26 Y 1.0))
            (+ (*/ 0.23 X 1.0) (*/ 0.22 Y 1.0) 1.6) ) ) 
      (T
         (list
            (+ (*/ -0.15 X 1.0) (*/ 0.28 Y 1.0))
            (+ (*/ 0.26 X 1.0) (*/ 0.24 Y 1.0) 0.44) ) ) ) )
(let (X 0  Y 0  G)
   (setq G
      (make
         (do 640
            (link (need 640 0)) ) ) )
   (mapc
      '((N)
         (let ((A B) (calc N X Y))
            (setq X A  Y B)
            (set (nth G (gridY Y) (gridX X)) 1)
         )
      )
      (10 20 30 40 50 60 70 80 85 86 87 93 94 95 96 0 1 2 3 4 5 6 7 8 9 10) )
   (println
      'fin
      (format X *Scl)
      (format Y *Scl) )
)
(msg 'ok)
(bye)
