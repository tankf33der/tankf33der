(off 'R)

(idx 'R (list "A" 1 (list 12 1) 12) T)
(idx 'R (list "B" -1 (list 12 1) 120) T)
(when (lup R "A")
      (let (B (get @ 2) D (get @ 4))
         (put @ 2 123)
         (put @ 4 1230)


      # (set (cdr @) 123)       # set B
      # (set (cdddr @) 1230)    # set D
      # (inc (caddr @) 1000)    # sum
      # (inc (cdaddr @))        # set count
)
(println 'R R)

(msg 'ok)
(bye)
