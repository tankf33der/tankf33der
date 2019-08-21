(setq 
   *PRIME1 2654435761
   *PRIME2 2246822519
   *PRIME3 3266489917
   *PRIME4 668265263
   *PRIME5 374761393 )
(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )
(de mod32+ @
   (mod32 (pass +)) )
(de mod32* (A B)
   (mod32 (* A B)) )
(de rol32 (X C)
   (| (mod32 (>> (- C) X)) (>> (- 32 C) X)) )
(de num32xx (L)
   (apply | (mapcar >> (0 -8 -16 -24) L)) )
(de xxhash32 (Lst)
   (let (Len (length Lst)  LenTemp Len  H32 0)
      (if (< Len 16) 
         (setq H32 *PRIME5)
         (let (V1 (mod32+ *PRIME1 *PRIME2)  V2 *PRIME2  V3 0  V4 1640531535)
            (while (>= Len 16)
               (setq
                  V1
                  (mod32*
                     *PRIME1
                     (rol32
                        (mod32+ V1 (* *PRIME2 (num32xx (cut 4 'Lst))))
                        13 ) )
                  V2
                  (mod32*
                     *PRIME1
                     (rol32 
                        (mod32+ V2 (* *PRIME2 (num32xx (cut 4 'Lst)))) 
                        13 ) )
                  V3
                  (mod32*
                     *PRIME1
                     (rol32
                        (mod32+ V3 (* *PRIME2 (num32xx (cut 4 'Lst)))) 
                        13 ) )
                  V4
                  (mod32*
                     *PRIME1
                     (rol32
                        (mod32+ V4 (* *PRIME2 (num32xx (cut 4 'Lst)))) 
                        13 ) ) )
               (dec 'Len 16) )
            (setq H32
               (mod32+
                  (rol32 V1 1)
                  (rol32 V2 7)
                  (rol32 V3 12)
                  (rol32 V4 18) ) ) ) )
      (setq H32 (mod32+ H32 LenTemp))
      (while (cdddr Lst)
         (setq H32
            (mod32*
               *PRIME4
               (rol32 
                  (mod32+ H32 (* *PRIME3 (num32xx (cut 4 'Lst)))) 
                  17 ) ) ) )
      (for I Lst
         (setq H32
            (mod32* *PRIME1 (rol32 (mod32+ H32 (* *PRIME5 I)) 11)) ) ) 
      (setq
         H32 (mod32* (x| H32 (>> 15 H32)) *PRIME2)
         H32 (mod32* (x| H32 (>> 13 H32)) *PRIME3)
         H32 (x| H32 (>> 16 H32)) ) ) )

