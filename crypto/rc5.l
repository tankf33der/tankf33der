#
# RC5-64/12/16
#
(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )
(de rol32 (X C)
   (| (mod32 (>> (- C) X)) (>> (- 32 C) X)) )
(de mod32+ @ 
   (mod32 (pass +)) )
(de mod32* (A B)
   (mod32 (* A B)) )
(de inc32 (A)
   (mod32+ 1 A) )
(de key32 (L)
   (apply
      circ
      (make
         (do 4
            (link (num32 (cut 4 'L))) ) ) ) )
(de num32 (L)
   (apply
      |
      (mapcar >> (0 -8 -16 -24) L) ) )
(de rc5 (Lst Key)
   (or
      (and
         (= 8 (length Lst))
         (= 16 (length Key)) )
      (quit "wrong length") )
   (let (Key (key32 Key)  S NIL)
      (setq S
         (apply
            circ
            (make
               (setq @ (link `(hex "B7E15163")))
               (do 25
                  (setq @ (link (mod32+ @ `(hex "9E3779B9")))) ) ) ) )
      (zero @ @@)
      (do 78 # (* 3 (* 2 (+ 12 1)))
         (setq 
            @
            (set S
               (rol32 (mod32+ @ @@ (pop 'S)) 3) )
            @@
            (set Key
               (rol32
                  (mod32+ @ @@ (pop 'Key))
                  (& (mod32+ @ @@) 31) ) ) ) )
      (setq 
         @  (mod32+ (num32 (cut 4 'Lst)) (pop 'S))
         @@ (mod32+ (num32 (cut 4 'Lst)) (pop 'S)) )
      (do 12
         (setq 
            @
            (mod32+
               (rol32 (x| @ @@) (& @@ 31)) 
               (pop 'S) )
            @@
            (mod32+
               (rol32 (x| @ @@) (& @ 31))
               (pop 'S) ) ) )
      (make
         (for N (list @ @@)
            (do 4
               (link (& 255 N))
               (setq N (>> 8 N)) ) ) ) ) )

