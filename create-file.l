(let L (need 256 'A)
   (out "B.txt"
      (for N 256
         (prinl (place N L 'Z)) ) ) )
(msg 'ok)
(bye)

