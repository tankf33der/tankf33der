`(== 64 64)

(setq Prg
   '((set i 31) (set a 1) (mul p 17) (jgz p p) 
   (mul a 2) (add i -1) (jgz i -2) (add a -1)
   (set i 127) (set p 952) (mul p 8505) (mod p a) 
   (mul p 129749) (add p 12345) (mod p a) 
   (set b p) (mod b 10000) (snd b) (add i -1) 
   (jgz i -9) (jgz a 3) (rcv b) (jgz b -1) 
   (set f 0) (set i 126) (rcv a) (rcv b) 
   (set p a) (mul p -1) (add p b) (jgz p 4) 
   (snd a) (set a b) (jgz 1 3) (snd b) 
   (set f 1) (add i -1) (jgz i -11) (snd a) 
   (jgz f -16) (jgz a -19) ) )


(de f18-init (A)
   (or
      (num? A)
      (assoc A R)
      (push 'R (list A 0)) ) )
(de f18-eval (A)
   (if (num? A) @ (cadr (assoc A R))) )
(de f18-exec-child (L)
   (println 'ch-exec 'L L)
   (f18-init (cadr L))
   (prog1
      (case (car L)
         (("snd" "rcv") (f18-child L))
         (T (f18-generic L)) )
      (or (= "jgz" (car L)) (inc 'I)) ) )
(de f18-exec-parent (L)
   (println 'prn-exec 'L L)
   (f18-init (cadr L))
   (prog1
      (case (car L)
         (("snd" "rcv") (f18-parent L))
         (T (f18-generic L)) )
      (or (= "jgz" (car L)) (inc 'I)) ) )
(de f18-generic (L)
   (case (car L)
      ("set"
         (set
            (cdr (assoc (cadr L) R))
            (f18-eval (caddr L)) ) )
      ("add"
         (inc
            (cdr (assoc (cadr L) R))
            (f18-eval (caddr L)) ) )
      ("mul" 
         (set (cdr (assoc (cadr L) R))
            (* 
               (cadr (assoc (cadr L) R))
               (f18-eval (caddr L)) ) ) )
      ("mod"
         (set (cdr (assoc (cadr L) R))
            (%
               (cadr (assoc (cadr L) R))
               (f18-eval (caddr L)) ) ) )
      ("jgz"
         (if (gt0 (f18-eval (cadr L)))
            (inc 'I (f18-eval (caddr L)))
            (inc 'I) ) ) 
   )
)
(de f18-child (L)
   (case (car L)
      ("snd" (yield (f18-eval (cadr L))))
      ("rcv"
         (set
            (cdr (assoc (cadr L) R))
            (yield 'giveme) )
         (yield 'ok) )
   )
   T # always success
     # XXX, deadlock detection
)
(de f18-parent (L)
   (case (car L)
      ("snd"
         (fifo 'CB (f18-eval (cadr L)))
         (inc 'C) )
      ("rcv"
         (set
            (cdr (assoc (cadr L) R))
            (fifo 'PB) ) )
   )
)

(de child (Prg)
   (co 'child
      (let (Prg Prg  R '((p 0))  I 1)
         (yield 'ready)
         (while
            (and
               (>= (length Prg) I) # XXX
               (f18-exec-child (get Prg I)) )
         )
         (println 'fin 'R R)
         NIL # finish
      )
   )
)

(de parent (Prg)
   (let (Flg T CB NIL  PB NIL  R '((p 1))  I 1 C 0) # XXX, empty box!
      (println 'start 'Prg Prg)
      (child Prg)
      (while
         (and
            (>= (length Prg) I) # XXX
            (f18-exec-parent (get Prg I))
            )
         (when Flg
            (if (child)
               (if (num? @)
                  (fifo 'PB @) # snd
                  (yield (fifo 'CB) 'child) )
               (off Flg) )
         )
         
      ) 
#{
      (when (setq @@ (child))
         (println '@@ @@)
         (if (num? @@)
            (fifo 'PB @@) # snd
            (yield (fifo 'CB) 'child)
         )
      )
}#
      (println 'prn-fin 'R R)
      (println 'prn-fin 'CB CB 'PB PB)
      (println 'C C)
   )
)

#(setq Prg
#   '((snd 111) (snd 22) (rcv a) (add a 10) (set a 777) (rcv z) (add z 5)) )

#(setq Prg
#   '((snd 1) (snd 2) (snd p) (rcv a) (rcv b) (rcv c) (rcv d)) )

#{
(setq Prg
   (quote
      (set a 1) (set b 2) (add a 10) (mul a 100) (mod a 15) (add b 20)
   ) 
)
}#

(parent Prg)


(msg 'ok)
(bye) 
