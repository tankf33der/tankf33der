# https://wiki.tcl-lang.org/page/Fixed-point+arithmetic
(scl 4)
(setq
   X 17000.00
   P 3.2571
   R (*/ X P 100.00) )
(test "553.71" (round R 2))
(msg 'ok)
(bye)
