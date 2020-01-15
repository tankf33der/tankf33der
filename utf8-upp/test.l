(load "utf8-tables.l")
(de u? (N)
   (find
      '((L) (<= (car L) N (cadr L)))
      *U ) )
(println (car (argv)))
(zero C)
(in (car (argv))
   (until (eof)
      (and (u? (char (char))) (inc 'C)) ) )
(println 'C C)

(msg 'ok)
(bye)
