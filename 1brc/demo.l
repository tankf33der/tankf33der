(off R)
(in "small.csv"
   (until (eof)
      (let (A (prog1 (till ";" T) (char))  B (format (line T) 4))
         (ifn (idx 'R A T)
            (set A (list 1 B B B))
            (let Lst (val (car @))
               (println 'Lst Lst)
               (inc Lst)



               # (when (< B (get Lst 2)) (set (cdr Lst) B))
               # (when (> B (get Lst 4)) (put Lst 4 B))
               # (put Lst 3 (+ B (get Lst 3))) ) ) ) ) )
            )
         )
      )
   )
)

(println (caar (idx 'R "A")))

# (9 -346000 639952 379905)
# (println (caar (idx 'R "San Rafael")))

(msg 'ok)
(bye)
