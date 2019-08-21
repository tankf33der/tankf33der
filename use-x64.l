(de SS (L)
   (use (T0)
      (set
         'T0 123
         (nth L 6) (x| 1 T0) ) ) )
(de jh256 (Lst)
   (let HL (range 1 8)
      (SS HL)
      (println HL) ) )

(and *Dbg (trace 'x|))
(jh256 (1))
(jh256 (1))
        
(bye) 
