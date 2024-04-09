(let L (need 1024 'A)
   (out "B.txt"
      (for N 1024
         (prinl (place N L 'Z)) ) ) )
(msg 'ok)
(bye)

