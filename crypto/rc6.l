(load "rc5.l")

# RC6-128-128
(de rc6 (Lst Key)
   (or 
      (= 
         16 
         (length Lst)
         (length Key) )
      (quit "wrong length") )
   (let
      (Key (key32 Key)
         A (num32 (cut 4 'Lst))
         B (num32 (cut 4 'Lst))
         C (num32 (cut 4 'Lst))
         D (num32 (cut 4 'Lst))
         S NIL )
      (setq S
         (apply
            circ
            (make
               (setq @ (link `(hex "B7E15163")))
               (do 43
                  (setq @ (link (mod32+ @ `(hex "9E3779B9")))) ) ) ) )
      (zero @ @@)
      (do 132 # (* 3 (+ (* 2 20) 4))
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
         B (mod32+ B (pop 'S))
         D (mod32+ D (pop 'S)) )
      (do 20
         (setq
            @
            (rol32
               (mod32* B (inc32 (mod32* B 2)))
               5 )
            @@
            (rol32
               (mod32* D (inc32 (mod32* D 2)))
               5 )
            A
            (mod32+
               (rol32 (x| A @) (& @@ 31))
               (pop 'S) )
            C
            (mod32+
               (rol32 (x| C @@) (& @ 31))
               (pop 'S) ) ) 
         (swap 'A (swap 'B (swap 'C (swap 'D A)))) )
      (setq
         A (mod32+ A (pop 'S))
         C (mod32+ C (pop 'S)) )
      (make
         (for N (list A B C D)
            (do 4
               (link (& 255 N))
               (setq N (>> 8 N)) ) ) ) ) )

