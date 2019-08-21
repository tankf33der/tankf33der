(let N 512
   (while (gt0 (swap 'N (/ N 2)))
      (prinl (pad 10 (bin @))) ) )

(msg 'ok)
(bye)
