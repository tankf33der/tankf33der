# first read this:
# https://the-m6.net/blog/fixed-point-arithmetic-in-picolisp/

(scl 4)

# plus or minus
(test 7 (+ 4 3))        # for humans
(test
   "15.3345"            # both fixedpoints
   (format (+ 11.2345 4.1) *Scl) )
(test                   # fixedpoint "11.2345" and
   "15.2345"            # number "4" converted
   (format (+ 11.2345 (* 4 1.0)) *Scl) )


# multiplication
(test 24 (* 6 4))       # for humans
(test
   "49.2366"            # both fixedpoints
   (format (*/ 12.34 3.99 1.0) *Scl) )
(test                   # number "25"
   "308.5000"           # and fixedpoint "12.34"
   (format (* 25 12.34) *Scl) )


# division
(test 2 (/ 12 6))       # for humans
(test
   "3.2732"             # both fixedpoints
   (format (*/ 1.0 12.34 3.77) *Scl) )
(test                   # number "14" converted
   "1.1345"             # and fixedpoint "12.34".
   (format (*/ 1.0 14 1.0 12.34) *Scl) )
(test                   # fixedpoint "12.34"
   "0.8814"             # and number "14"
   (format (/ 12.34 14) *Scl) )


(msg 'ok)
(bye)
