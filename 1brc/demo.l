(off 'R)

(println 1 (lup R "A"))
(idx 'R (list "A" 1 (list 12 1) 12) T)
(idx 'R (list "B" -1 (list 12 1) 120) T)
(when (lup R "A")
      (set (cdr @) 123)       # B
      (set (cdddr @) 1230)    # D
      (inc (caddr @) 1000)    # sum
      (inc (cdaddr @))
      #(inc C 100)             # sum
      #(inc (cdr C))           # count

)
(println 'R R)


(msg 'ok)
(bye)
