(de aggrcow (Lst K)
# Lst already sorted
   (let
      (Lo 0
         Hi (inc (- (last Lst) (car Lst))) )
      (while (> (- Hi Lo) 1)
         (let
            (Mid (/ (+ Hi Lo) 2)
               Last (car Lst)
               P 1 )
            (for L (cdr Lst)
               (and
                  (>= (- L Last) Mid)
                  (inc 'P)
                  (setq Last L) ) )
            (set (if (>= P K) 'Lo 'Hi) Mid) ) )
      Lo ) )

(de arith (Lst)
   (let
      (Lst (chop Lst)
         L (split Lst '+ '- '*)
         A (format (++ L))
         B (format (++ L))
         S
         (intern 
            (find '((I) (not (format I))) Lst) )
         R (S A B)
         L (max (length A) (inc (length B)) (length R))
         LenA (length A)
         LenB (length B) )
      (prinl (align L A))
      (prinl (align L (pack S B)))
      (if (memq S '(- +))
         (prinl (pack (need L '-)))
         (prinl
            (align 
               L 
               (pack (need (max LenA (inc LenB)) '-)) ) )
         (when (> (min LenA LenB) 1)
            (let N (inc L)
               (for X (mapcar format (flip (chop B)))
                  (prinl (align (dec 'N) (* X A))) )
               (prinl (pack (need L '-))) ) ) ) 
      (prinl (align L R))
      (prinl) ) )

(de bead (Line) # by @joebo
   (let
      (Len (length Line)
         L (apply 'circ (chop Line))
         Shifts
         (reverse (make (do Len (link (pack (head Len (rot L)))))))
         Sorted (sort (copy Shifts))
         WorstItem (car Sorted) )
      (index WorstItem Shifts) ) )


(msg 'ok)
(bye)
