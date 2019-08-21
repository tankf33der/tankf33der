# https://github.com/funny-falcon/fanom_hash
#

(de mod (N)
   (& N `(hex "FFFFFFFF")) )
(de add (A B)
   (+ A B) )
(de rol (X C)
   (| (>> (- C) X) (>> (- 32 C) (mod X))) )
(de ror (X C)
   (| (>> C (mod X)) (>> (- C 32) X)) )
(de endian (L) # little
   (apply
      |
      (mapcar >> (0 -8 -16 -24) L) ) )
(de lucky777_permute (V "A" "B")
   (set
      "A" (add (val "A") V)
      "B" (x| (val "B") (val "A"))
      "A" (add (rol (val "A") 7) (val "B"))
      "B" (x| (ror (val "B") 7) (val "A"))
      "A" (rol (val "A") 7) ) )
(de lucky777_finalize ("A" "B")
   (set
      "A" (x| (val "A") (val "B"))
      "A" (add (val "A") (ror (val "B") 3))
      "B" (x| (val "A") (val "B"))
      "B" (add (val "B") (rol (val "A") 5))
      "A" (x| (val "A") (val "B"))
      "A" (add (val "A") (ror (val "B") 8))
      "B" (x| (val "A") (val "B"))
      "B" (add (val "B") (rol (val "A") 16)) ) )
(de lucky777 (Lst S1 S2 S3)
   (default S2 (x| S1 `(hex "eb0d2f41"))  S3 0)
   (let 
      (Len (length Lst)
         L (>> -24 Len)
         Lst (copy Lst) )
      # A S1; B S2
      (while (> Len 3)
         (lucky777_permute (endian (cut 4 'Lst)) 'S1 'S2)
         (dec 'Len 4) )
      (when (gt0 Len)
         (setq L 
            (| 
               L
               (endian
                  (conc (need -3 Lst (last Lst)) (need 1 0)) ) ) ) )
      (lucky777_permute L 'S1 'S2)
      (and
         (gt0 S3)
         (setq S2 (add S2 S3)) )
      (lucky777_finalize 'S1 'S2)
      (mod S2) ) )

