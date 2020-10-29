(load "@lib/simul.l")
(seed (in "/dev/urandom" (rd 8)))
(let
   (Colors (list 31 32 33 35 91 92 93 94 96)
      G (simul~grid 22 79)
   )
   (for L G
      (for This L
         (let X (rand 1 9)
            (=: N X)
            (=: C (get Colors X)) ) ) )
   (with (get G (rand 1 22) (rand 1 79))
      (=: N 0) )
   (for L G
      (for This L
         (prin
            "^[[0;"
            (if (=0 (: N)) 100 (: C))
            "m"
            (if (=0 (: N)) "@" (: N))
            "^[[0m" ) )
      (prinl) )


)
# (79 22)
#(println (length (car Grid)) (length Grid))

#{
(do 9
(call 'clear)
(for G Grid
   (for L G
      (prin C) )
   (prinl) )
(inc 'C)
(wait 900)
)
}#


(bye)
