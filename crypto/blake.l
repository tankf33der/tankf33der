(load "blake-sbox.l")

(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )
(de add32 @
   (mod32 (pass +)) )
(de Gfunc (A B C D I)
   (let
      (VA (get "V" A)
         VB (get "V" B)
         VC (get "V" C)
         VD (get "V" D)
         X NIL
         SR (car (nth *BLAKE-SIGMA R I))
         SR1 (car (nth *BLAKE-SIGMA R (inc I))) )
      (setq
         VA
         (add32 
            VA 
            VB
            (x| (get "M" SR) (get *BLAKE256-C SR1)) )
         X (x| VD VA)
         VD (| (>> 16 X) (mod32 (>> -16 X)))
         VC (add32 VC VD)
         X (x| VB VC)
         VB (| (>> 12 X) (mod32 (>> -20 X)))
         VA
         (add32
            VA
            VB
            (x|
               (get "M" SR1) (get *BLAKE256-C SR)) )
         X (x| VD VA)
         VD (| (>> 8 X) (mod32 (>> -24 X)))
         VC (add32 VC VD)
         X (x| VB VC)
         VB (| (>> 7 X) (mod32 (>> -25 X))) )
      (set
         (nth "V" A) VA
         (nth "V" B) VB
         (nth "V" C) VC
         (nth "V" D) VD ) ) )
(de blake256 (Lst)
   (let 
      (Len (length Lst)
         BitsAll (* 8 Len)
         BitsDone 0
         "H"
         (mapcar
            hex
            (quote
               "6A09E667" "BB67AE85" "3C6EF372" "A54FF53A"
               "510E527F" "9B05688C" "1F83D9AB" "5BE0CD19" ) ) )
      (setq Lst
         (append
            Lst
            (if (= 440 (% BitsAll 512))
               (cons 129)
               (conc
                  (cons 128)
                  (need
                     (- 
                        (* 64 (/ (+ 2 8 Len 63) 64))
                        9
                        Len )
                     (cons 1)
                     0 ) ) )
            (make
               (setq Len BitsAll)
               (do 8
                  (yoke (& Len 255))
                  (setq Len (>> 8 Len)) ) ) ) )
      (while Lst
         (let
            ("M"
               (make
                  (do 16
                     (link
                        (apply 
                           |
                           (mapcar >> (-24 -16 -8 0) (cut 4 'Lst)) ) ) ) )
               "V" NIL )
            (cond
               ((=0 BitsAll) (zero BitsDone))
               ((>= 512 BitsAll)
                  (inc 'BitsDone (swap 'BitsAll 0)) )
               (T (inc 'BitsDone 512) (dec 'BitsAll 512)) )
            (setq "V"
               (make
                  (chain (copy "H"))
                  (chain (head 4 *BLAKE256-C))
                  (link 
                     (x| BitsDone (get *BLAKE256-C 5))
                     (x| BitsDone (get *BLAKE256-C 6)) )
                  (link
                     (x| (>> 32 BitsDone) (get *BLAKE256-C 7))
                     (x| (>> 32 BitsDone) (get *BLAKE256-C 8)) ) ) ) 
            (for R 14
               (Gfunc 1 5 9 13 1)
               (Gfunc 2 6 10 14 3)
               (Gfunc 3 7 11 15 5)
               (Gfunc 4 8 12 16 7)
               (Gfunc 1 6 11 16 9)
               (Gfunc 2 7 12 13 11)
               (Gfunc 3 8 9 14 13)
               (Gfunc 4 5 10 15 15) )
            (let (LH (head 8 "V")  LT (tail 8 "V"))
               (for (L "H" L)
                  (set L
                     (x|
                        (pop 'L)
                        (pop 'LH)
                        (pop 'LT) ) ) ) ) ) )
      (let C (circ 24 16 8 0)
         (make
            (for N "H"
               (do 4
                  (link (& (>> (pop 'C) N) `(hex "FF"))) ) ) ) ) ) )
(de blake256_hex (Lst)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (blake256 Lst) ) ) )

