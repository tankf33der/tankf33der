`(== 64 64)

#{
((set i 31) (set a 1) (mul p 17) (jgz p p) 
   (mul a 2) (add i -1) (jgz i -2) (add a -1)
   (set i 127) (set p 952) (mul p 8505) (mod p a) 
   (mul p 129749) (add p 12345) (mod p a) 
   (set b p) (mod b 10000) (snd b) (add i -1) 
   (jgz i -9) (jgz a 3) (rcv b) (jgz b -1) 
   (set f 0) (set i 126) (rcv a) (rcv b) 
   (set p a) (mul p -1) (add p b) (jgz p 4) 
   (snd a) (set a b) (jgz 1 3) (snd b) 
   (set f 1) (add i -1) (jgz i -11) (snd a) 
   (jgz f -16) (jgz a -19) )
}#

(de child (Prg R)
   (if (=T Prg)
      (co 'child)
      (co 'child
         (let (Prg Prg  R R)
         (yield 'ready)
            (for P Prg
               (case (car P)
                  ("snd" (yield (list ID @ (cadr P))))
                  ("rcv"
                     (set
                        (cdr (assoc (cadr P) R))
                        (yield (list ID @)) )
                     (yield) # Got one
                  )
               )
            )
            (println 'R-c1 R)
            NIL # finish
         )
      )
   )
)

(de parent (Prg)
   (let (CB NIL  PB NIL)
      (fifo 'CB 555)
      (println (child Prg '((a 11) (z 0))))
      (while (setq @@ (child))
         (println '@@ @@)
         (case (cadr @@)
            ("snd" (fifo 'CB (caddr @@)))
            ("rcv" (yield (fifo 'CB) 'child))
         )
      )
   )
)

(setq Prg '((snd 111) (snd 22) (rcv a) (rcv z)))
(parent Prg)


(msg 'ok)
(bye) 

