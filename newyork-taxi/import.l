`(== 64 64)
(load "db.l")

(scl 2)
(prune 0)
(gc 2048 512)
(in "yellow_tripdata_2017-01.csv"
   (line) # header
   (line) # break
   (while (line)
      (let L (cdr (split @ ","))
         (at (0 . 10000) (prinl "!") (commit) (prune 256))
         (new 
            `(db: +Cab)
            '(+Cab)
            'pd
            ($dat (pack (head 10 (car L))) "-")
            'pt
            ($tim (pack (nth (++ L) 11)))
            'dd
            ($dat (pack (head 10 (car L))) "-")
            'dt
            ($tim (pack (nth (++ L) 11)))
            'pcnt
            (format (++ L))
            'code
            (format (prog (++ L) (++ L)))
            'ploc
            (format (prog (++ L) (++ L)))
            'type
            (format (prog (++ L) (++ L)))
            'amnt
            (format (prog (do 6 (++ L)) (++ L)) 2) )
      )
   )
)
(commit)
(prune)
(gc 0)


(msg 'ok)
(bye)
