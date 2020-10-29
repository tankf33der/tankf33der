(load "@lib/simul.l")
(seed (in "/dev/urandom" (rd 8)))
(let
   (Colors (list 31 32 33 35 91 92 93 94 96)
      G (simul~grid 22 79)
      C NIL
   )
   (for L G
      (for This L
         (let X (rand 1 9)
            (=: N X)
            (=: C (get Colors X)) ) ) )
   (with (get G (rand 1 22) (rand 1 79))
      (setq C This)
      (=: N 0) )
   (for L G
      (for This L
         (prin
            "^[[0;"
            (if (or (: F) (=0 (: N))) 100 (: C))
            "m"
            (if (=0 (: N)) "@" (: N))
            "^[[0m" ) )
      (prinl) )
   (with C
      (println 'C C)
      (setq Z
         (extract
            '((D)
               (with C
                  (let? S (with (D This) (: N))
                     (and
                        (do S
                           (setq This (D This)) )
                        (list S D)
                     )
                  )
               )
            )
            '(simul~west simul~east simul~south simul~north
               ((X) (simul~south (simul~west X)))
               ((X) (simul~north (simul~west X)))
               ((X) (simul~south (simul~east X)))
               ((X) (simul~north (simul~east X))) )
         ) # filter
      )
      (println 'Z Z)
   )


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
