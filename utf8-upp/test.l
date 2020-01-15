(load "utf8-tables.l")
(de u? (N)
   (find
      '((L) (<= (car L) N (cadr L)))
      *U ) )
(zero C)
(in "utf8-full-.dat"
   (until (eof)
      (and (u? (char (char))) (inc 'C)) ) )
(println 'C C)

(msg 'ok)
(bye)
