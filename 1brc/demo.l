(off 'R)

(idx 'R (list "A" 1 (list 12 1) 12) T)
(idx 'R (list "B" -1 (list 12 1) 120) T)
(when (lup R "A")
      (println 'B (get @ 2))
      (println 'D (get @ 4))
      (set (cdr @) 123)       # B
      (set (cdddr @) 1230)    # D
      (inc (caddr @) 1000)    # sum
      (inc (cdaddr @))
)
(println 'R R)

(msg 'ok)
(bye)
