(load "blowfish-sbox.l")

(de mod8 (N)
   (& N `(hex "FF")) )
(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )
(de mod32+ (A B)
   (mod32 (+ A B)) )
(de blowfish_round (A B N)
   (x|
      A
      (x|
         N
         (mod32+
            (get *S3 (inc (mod8 B)))
            (x|
               (get *S2 (inc (mod8 (>> 8 B))))
               (mod32+
                  (get *S0 (inc (mod8 (>> 24 B))))
                  (get *S1 (inc (mod8 (>> 16 B)))) ) ) ) ) ) )
(de blowfish_encrypt ()
   (setq *xL (x| *xL (car *P)))
   (for (L (cdr *P) (cddr L) (cddr L))
      (setq
         *xR (blowfish_round *xR *xL (car L))
         *xL (blowfish_round *xL *xR (cadr L)) ) )
   (setq *xR (x| *xR (last *P)))
   (xchg '*xL '*xR) ) 
(de blowfish (Lst Key)
   ~(assert (> 56 (length Key)))
   (let
      (*P (copy *P-Init)
         *S0 (copy *S0-Init)
         *S1 (copy *S1-Init)
         *S2 (copy *S2-Init)
         *S3 (copy *S3-Init)
         *xL 0
         *xR 0
         Key (apply circ Key)
         Len (length Lst)
         Lst
         (need
            (- (>> -3 (>> 3 (+ 7 Len))))
            (copy Lst)
            0 ) )
      (for (L *P L)
         (set L
            (x|
               (car L)
               (|
                  (>> -24 (pop 'Key)) 
                  (>> -16 (pop 'Key)) 
                  (>> -8 (pop 'Key)) 
                  (pop 'Key) ) ) )
         (pop 'L) )
      (for Lst '(*P *S0 *S1 *S2 *S3)
         (for (L (val Lst) L)
            (blowfish_encrypt)
            (set L *xL)
            (pop 'L)
            (set L *xR)
            (pop 'L) ) )
      (make
         (while Lst
            (setq 
               *xL
               (|
                  (>> -24 (pop 'Lst))
                  (>> -16 (pop 'Lst))
                  (>> -8 (pop 'Lst))
                  (pop 'Lst) )
               *xR
               (|
                  (>> -24 (pop 'Lst))
                  (>> -16 (pop 'Lst))
                  (>> -8 (pop 'Lst))
                  (pop 'Lst) ) )
            (blowfish_encrypt)
            (link
               (mod8 (>> 24 *xL))
               (mod8 (>> 16 *xL))
               (mod8 (>> 8 *xL))
               (mod8 *xL)
               (mod8 (>> 24 *xR))
               (mod8 (>> 16 *xR))
               (mod8 (>> 8 *xR))
               (mod8 *xR) ) ) ) ) )
(de blowfish_hex (Lst Key)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (blowfish Lst Key) ) ) )
