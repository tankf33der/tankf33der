# (in "small.csv"
#    (until (eof)
#       (skip "#")
#       (let (A (prog1 (till ";" T) (char))  B (format (line T) 4))
#          (if (setq Z (lup R A))
#             (let (B1 (get Z 2)  D1 (get Z 4))
#                (when (< B B1) (set (cdr Z) B))
#                (when (> B B1) (set (cdddr Z) B))
#                (inc (caddr Z) B)
#                (inc (cdaddr Z)) )
#             (idx 'R (list A B (list B 1) B) T) ) ) ) )


(off 'R)
(idx 'R "A" T)
(set "A" (list 1 2))

(msg 'ok)
(bye)
