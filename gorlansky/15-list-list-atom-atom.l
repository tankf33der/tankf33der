#15.1
(de f15-1 (C LstC LstS)
   (get LstS (index C LstC)) )
(test
   'Berlin
   (f15-1
      'Germany
      '(RF USA Germany UK)
      '(Moscow Washington Berlin London) ) )

