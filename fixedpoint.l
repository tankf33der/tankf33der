(scl 4)

# plus or minus
(test 7 (+ 4 3))        # for humans
(test
   "15.3345"            # both fixedpoints
   (format (+ 11.2345 4.1) *Scl) )
(test                   # fixedpoint "11.2345" and
   "15.2345"            # human number "4" converted
   (format (+ 11.2345 (* 4 1.0)) *Scl) )

# multiplication
(test 24 (* 6 4))       # for humans
(test
   "49.2366"            # both fixedpoints
   (format (*/ 12.34 3.99 1.0) *Scl) )
(test                   # human number "25" converted
   "308.5000"           # and fixedpoint "12.34"
   (format (*/ 25 1.0 12.34 1.0) *Scl) )



(msg 'ok)
(bye)
