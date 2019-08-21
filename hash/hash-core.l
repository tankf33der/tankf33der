(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )
(de leftRotate (X C)
   (| (mod32 (>> (- C) X)) (>> (- 32 C) X)) )
(de rightRotate (X C)
   (| (>> C X) (mod32 (>> (- C 32) X))) )
(de mod32+ (A B)
   (mod32 (+ A B)) )
(de mod32* (A B)
   (mod32 (* A B)) )

(de endian (L) # little
   (apply
      |
      (mapcar >> (0 -8 -16 -24 -32 -40 -48 -56) L) ) )
(de mod64 (N)
   (& N `(hex "FFFFFFFFFFFFFFFF")) )
(de mod64+ (A B)
   (mod64 (+ A B)) )
(de rol64 (X C)
   (| (mod64 (>> (- C) X)) (>> (- 64 C) X)) )

