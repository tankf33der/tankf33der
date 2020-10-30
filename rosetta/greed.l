(load "@lib/simul.l")
(seed (in "/dev/urandom" (rd 8)))
# N - number
# C - Color
# F - flag to draw candidates
# A - @ mark
(de display ()
   (wait 500)
   (call 'clear)
   (for L G
      (for This L
         (prin
            "^[[0;"
            (if (or (: A) (: F)) 100 (: C))
            "m"
            (cond
               ((: A) "@")
               ((lt0 (: N)) " ")
               (T (: N)) )
            "^[[0m" ) )
      (prinl) ) )
(let
   (Colors (list 31 32 33 35 91 92 93 94 96)
      G (simul~grid 22 79)
      C NIL
      S 0
      P 0 )
   # set random grid
   (for L G
      (for This L
         (let X (rand 1 9)
            (=: N X)
            (=: C (get Colors X)) ) ) )
   # set random startpoint
   (with (get G (rand 1 22) (rand 1 79))
      (setq C This)
      (=: A 0) )
   (display)
(do 20
   (with C
      #(println 'C C)
      (setq Z
         (extract
            '((D)
               (with C
                  (let? S (with (D This) (: N))
                     (and
                        # XXX !!!
                        # check out of board and (gt0 (: N))
                        (do S
                           (setq This (D This)) )
                        (list S D This) ) ) ) )
            '(simul~west simul~east simul~south simul~north
               ((X) (simul~south (simul~west X))) ((X) (simul~north (simul~west X)))
               ((X) (simul~south (simul~east X))) ((X) (simul~north (simul~east X))) ) )
      ) # Z
      # XXX stop main loop if Z is empty
      #(println 'Z Z)

      (mapc
         '((L)
            (with C
               (do (car L)
                  (setq This ((cadr L) This))
                  (=: F T) ) ) )
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
            (=: N -1)
            (=: A)
            (do (car L)
               (=: N -1)
               (setq This ((cadr L) This))
            )
         )
         (with (caddr L)
            (setq C This)
            (=: A 0) )
      )
      (display)



   )

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
