(setq 
   *Tomo
   (0 3 2 5 0 3 5 1 4 6 2 4)
   *Days
   (quote
      "Sunday" "Monday" "Tuesday" "Wednesday"
      "Thursday" "Friday" "Saturday" ) )
(de dow (Y M D)
   (and (> 3 M) (dec 'Y))
   (get
      *Days
      (inc
         (%
            (-
               (+ 
                  Y 
                  (/ Y 4)
                  (/ Y 400) 
                  (get *Tomo M) 
                  D )
               (/ Y 100) )
            7 ) ) ) )
(for Y 9999
   (let Leap (date Y 2 29)
      (for M 12
         (for D
            (case M
               (2 (if Leap 29 28))
               ((1 3 5 7 8 10 12) 31)
               ((4 6 9 11) 30) ) 
         (test
            (day (date Y M D))
            (dow Y M D) ] 
(msg 'ok)
(bye)

