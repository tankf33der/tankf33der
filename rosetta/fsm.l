# http://rosettacode.org/wiki/Finite_state_machine
(seed (in "/dev/urandom" (rd 8)))

(de atm NIL
   (state '(ready)
      (ready (if (rand T) 'waiting 'quit)
         (prin "ready->") )
      (waiting (if (rand T) 'dispense 'refund)
         (prin "wait->") )
      (dispense 'ready
         (prin "dispense->") )
      (refund 'ready
         (prin "refund->") )
      (quit 'ready)
         (prin "quit")

   )
)

(do 10 (atm))

(msg 'ok)
(bye)
