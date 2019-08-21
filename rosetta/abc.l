#{ (println 'OK }#

(setq *Blocks
   '((B O) (X K) (D Q) (C P) (N A) (G T) (R E) 
   (T G) (Q D) (F S) (J W) (H U) (V I) (A N)
   (O B) (E R) (F S) (L Y) (P C) (Z M) ) )
(setq *Words '("" "A" "BARK" "BOOK" "TREAT" 
               "COMMON" "SQUAD" "Confuse"
               "abba" "ANBOCPDQERSFTGUVWXLZ") )

(de abc (W B)
   (let Myblocks (copy B)
      (fully
         '((C)
            (when (seek '((Lst) (member C (car Lst))) Myblocks)
               (set @)
               T ) )
      (chop (uppc W)) ) ) )
         
(for Word *Words
   (println Word (abc Word *Blocks) ) )

(bye)