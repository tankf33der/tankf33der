#
# Blowfish reimplementation for *Bcrypt* in mind
# custom, brutallity, advanced abstraction
# could pass original tests on vectors
#
(load "blowfish-sbox.l")

(de mod8 (N)
   (& N `(hex "FF")) )
(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )
(de mod32+ (A B)
   (mod32 (+ A B)) )
(de _brnd ("C" A B N) # Round
   (x|
      A
      (x|
         N
         (mod32+
            (car (nth (val "C") 5 (inc (mod8 B))))
            (x|
               (car (nth (val "C") 4 (inc (mod8 (>> 8 B)))))
               (mod32+
                  (car (nth (val "C") 2 (inc (mod8 (>> 24 B)))))
                  (car (nth (val "C") 3 (inc (mod8 (>> 16 B))))) ) ) ) ) ) )
(de _bstep ("C") # Feistel
   (setq *xL (x| *xL (caar (val "C"))))
   (for (L (cdar (val "C")) (cddr L) (cddr L))
      (setq
         *xR (_brnd "C" *xR *xL (car L))
         *xL (_brnd "C" *xL *xR (cadr L)) ) )
   (setq *xR (x| *xR (last (car (val "C")))))
   (xchg '*xL '*xR) )
(de bex ("C" Key) # expand key
   (let (*xL 0  *xR 0  K (apply circ Key))
      (for (L (car (val "C")) L)
         (set L
            (x|
               (car L)
               (|
                  (>> -24 (pop 'K)) 
                  (>> -16 (pop 'K)) 
                  (>> -8 (pop 'K)) 
                  (pop 'K) ) ) )
         (pop 'L) )
      (for Lst (val "C")
         (for (L Lst L)
            (_bstep "C")
            (set L *xL)
            (pop 'L)
            (set L *xR)
            (pop 'L) ) ) ) )
(de bexs ("C" Key Salt) # expand key+salt
   (let
      (*xL 0
         *xR 0
         K (apply circ Key)
         S (apply circ Salt) )
      (for (L (car (val "C")) L)
         (set L
            (x|
               (car L)
               (|
                  (>> -24 (pop 'K)) 
                  (>> -16 (pop 'K)) 
                  (>> -8 (pop 'K)) 
                  (pop 'K) ) ) )
         (pop 'L) )
      (for Lst (val "C")
         (for (L Lst L)
            (setq
               *xL
               (x|
                  *xL
                  (|
                     (>> -24 (pop 'S))
                     (>> -16 (pop 'S))
                     (>> -8 (pop 'S))
                     (pop 'S) ) )
               *xR
               (x|
                  *xR
                  (|
                     (>> -24 (pop 'S))
                     (>> -16 (pop 'S))
                     (>> -8 (pop 'S))
                     (pop 'S) ) ) )
            (_bstep "C")
            (set L *xL)
            (pop 'L)
            (set L *xR)
            (pop 'L) ) ) ) )
(de benc ("C" Lst) # Real encryption
   (let 
      (L 
         (need 
            (- 
               (>> -3 (>> 3 (+ 7 (length Lst))))) 
            (copy Lst) 
            0 )
         *xL 0
         *xR 0 )
      (make
         (while L
            (setq 
               *xL
               (|
                  (>> -24 (pop 'L))
                  (>> -16 (pop 'L))
                  (>> -8 (pop 'L))
                  (pop 'L) )
               *xR
               (|
                  (>> -24 (pop 'L))
                  (>> -16 (pop 'L))
                  (>> -8 (pop 'L))
                  (pop 'L) ) )
            (_bstep "C")
            (link
               (mod8 (>> 24 *xL))
               (mod8 (>> 16 *xL))
               (mod8 (>> 8 *xL))
               (mod8 *xL)
               (mod8 (>> 24 *xR))
               (mod8 (>> 16 *xR))
               (mod8 (>> 8 *xR))
               (mod8 *xR) ) ) ) ) )
# Helpers
(de bhex (Lst Key)
   (let "B"
      (mapcar
         '((L) (copy (val L)))
         '(*P-Init *S0-Init *S1-Init *S2-Init *S3-Init) )
      (bex '"B" Key)
      (pack
         (mapcar
            '((B) (pad 2 (hex B)))
            (benc '"B" Lst) ) ) ) )
(de bl (Lst Key)
   (let "B"
     (mapcar
         '((L) (copy (val L)))
         '(*P-Init *S0-Init *S1-Init *S2-Init *S3-Init) )
      (bex  '"B" Key) 
      (benc '"B" Lst) ) )

