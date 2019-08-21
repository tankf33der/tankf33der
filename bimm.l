
#Alex's version
(de bimm? (N) 
   (not (member "1" (member "0" (chop (bin N))))) )

(de bimm?-mike (N)
   (let L (chop (bin N))
      (while (= "1" (pop 'L)))
      (fully '((I) (= "0" I)) L) ) )
(for I 32 (println (bin I) (bimm? I)))  
(bye)

