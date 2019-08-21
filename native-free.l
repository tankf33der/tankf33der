`(== 64 64)

(let (Area (native "@" "malloc" 'N 1024))
   (use R
      (zero R)
      (for I 10
         (inc 'R I) )
      
      (println 'R R) 
      #(native "@" "free" NIL Area)
   )
   (native "@" "free" NIL Area)
)
   
(msg 'ok)
(bye)

