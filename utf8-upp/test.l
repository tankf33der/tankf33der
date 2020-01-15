(load "utf8-tables.l")
(de u? (N)
   (find
      '((L) (<= (car L) N (cadr L)))
      *U ) )
(zero C)
(zero Y)
(in (car (argv))
   (until (eof)
      (let Z (char (char))
         (inc 'Y Z)
         (and (u? Z) (inc 'C)) ) ) )
(println 'Y Y)
(println 'C C)


(msg 'ok)
(bye)
