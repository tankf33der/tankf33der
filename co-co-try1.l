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

(de f18-init (Lst)
   (for L Lst
      (or
         (num? L)
         (assoc L R)
         (push 'R (list L 0)) ) ) )
(de f18-eval (A)
   (if (num? A) @ (cadr (assoc A R))) )
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
            (inc 'I) ) ) ) )
(de f18-exec-child (L)
   (f18-init (cdr L))
   (prog1
      (case (car L)
         ("snd" 
            (yield (list (car L) (f18-eval (cadr L)))) )
         ("rcv"
            (set (cdr (assoc (cadr L) R)) (yield L)) )
         (T (f18-generic L)) )
      (or (= "jgz" (car L)) (inc 'I)) ) )
(de f18-exec-parent (L)
   (f18-init (cdr L))
   (prog1
      (case (car L)
         ("snd"
            (fifo 'CB (f18-eval (cadr L)))
            (inc 'C) )
         ("rcv"
            (if (cdr PB) # NOP
               (set (cdr (assoc (cadr L) R))
                  (fifo 'PB) )
               (dec 'I) ) )
         (T (f18-generic L)) )
      (or (= "jgz" (car L)) (inc 'I)) ) )
(de f18-child (Prg)
   (co 'child
      (let (PL (length Prg)  Prg Prg  I 1 R)
         (yield 'ready)
         (while (and (> PL I) (f18-exec-child (get Prg I)))
            (yield 'next) )
         NIL ) ) )
(de parent (Prg)
   (let
      (PL (length Prg)
         CB NIL
         PB NIL
         R '((p 1))
         I 1
         C 0 )
      (f18-child Prg) # init child
      (while (and (> PL I) (f18-exec-parent (get Prg I)))
         (when (setq @@ (f18-child))
            (case (car @@)
               ("snd"
                  (fifo 'PB (cadr @@))
                  (yield T 'child) )
               ("rcv" (yield (fifo 'CB) 'child)) ) ) )
      (while (setq @@ (f18-child))
         (case (car @@)
            ("snd"
               (fifo 'PB (cadr @@))
               (yield T 'child) ) 
            ("rcv" (yield (fifo 'CB) 'child)) ) )
      C ) )
(test 6858 (parent Prg))

(msg 'ok)
(bye)
