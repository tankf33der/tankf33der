(load "@lib/simul.l")
(seed (in "/dev/urandom" (rd 8)))
(de display ()
   (wait 600)
   #(call 'clear)
   (for L G
      (for This L
         (prin
            "^[[0;"
            (if (or (=0 (: F)) (=0 (: N))) 100 (: C))
            "m"
            (if2 (=0 (: N)) (lt0 (: N)) NIL "@" " " (: N))
            "^[[0m" ) )
      (prinl) ) )
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
   (display)
   (with C
      #(println 'C C)
      (setq Z
         (extract
            '((D)
               (with C
                  (let? S (with (D This) (: N))
                     (and
                        (do S
                           (setq This (D This)) )
                        (list S D This)
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
      ) # Z
      #(println 'Z Z)
      (mapc
         '((L)
            (with C
               (do (car L)
                  (setq This ((cadr L) This))
                  (=: F 0) ) ) )
         Z )
      (display)
      (mapc
         '((L)
            (with C
               (do (car L)
                  (setq This ((cadr L) This))
                  (=: F) ) ) )
         Z )
      (display)
      (let L (get Z (rand 1 (length Z)))
         (println 'L L)
         (with C
            (do (car L)
               (=: N -1)
               (setq This ((cadr L) This))
            )
         )
      )
      (display)



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
