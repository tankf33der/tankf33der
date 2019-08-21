(load "crypto/blowfish-sbox.l")

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
            (car (nth (val "C") 5 (rand 1 256)))
            (x|
               (car (nth (val "C") 4 (inc (mod8 (>> 8 B)))))
               (mod32+
                  (car (nth (val "C") 2 (inc (mod8 (>> 24 B)))))
                  (car (nth (val "C") 3 (inc (mod8 (>> 16 B))))) ) ) ) ) ) )
(de _bstep ("C") # Feistel
   (setq *xL (x| *xL (caar (val "C"))))
   (for (L (cdar (val "C")) (cddr L) (cddr L))
      (setq
         *xR (prog (inc '*Inc) (_brnd "C" *xR *xL (car L)))
         *xL (prog (inc '*Inc) (_brnd "C" *xL *xR (cadr L))) ) )
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

(setq 
   "B"
   (mapcar
      '((L) (copy (val L)))
      '(*P-Init *S0-Init *S1-Init *S2-Init *S3-Init) ) 
   *Inc 0
   *xL 0
   *xR 0 )

(bench
   (do 512
      (bex '"B" (1 2 3)) ) )
(println 'inc *Inc)

# 512, (1 2 3)
# (test
#   1470798409
#   (caadr "B") )

(msg 'ok)
(bye)
