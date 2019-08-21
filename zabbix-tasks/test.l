(load "code.l")

(test
   3
   (aggrcow (1 1 2 2 4 4 8 8 9 9) 3) )
(test
   3
   (aggrcow (1 2 4 8 9) 3) )
(test
   9
   (aggrcow (range 1 20) 3) )
(test
   6
   (aggrcow (range 1 20) 4) )
(test
   4
   (aggrcow (range 1 20) 5) )
(test
   500000000
   (aggrcow (0 500000000 1000000000) 3) )

#{ Uncomment for output
(arith "12345+67890")
(arith "324-111")
(arith "325*4405")
(arith "1234*4")
}#

(test 10 (bead "helloworld"))
(test 11 (bead "amandamanda"))
(test 6  (bead "dontcallmebfu"))
(test 5  (bead "aaabaaa"))

(msg 'ALL-OK)
(bye)
