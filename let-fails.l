(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )
(de mod32+ (A B)
   (mod32 (+ A B)) )
(setq L (range 1 40))
(off A)
(off B)
(off C)
(off D)
(let
   (Start (cut 4 'L)
      End (cut 4 'L) )
   (println 'Start Start 'End End 'L L)
   (do 8
      (println 'L L) 
      (setq
         A (pop 'L)
         B (pop 'L)
         B (mod32+ Tdd (pop 'L))
         D (pop 'L) )
      (println A B C D) )
         
)
(bye)
