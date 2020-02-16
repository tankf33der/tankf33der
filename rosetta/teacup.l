(setq Lst
   (make
      (in "../unixdict.txt"
         (while (line)
            (link @) ) ) ) )
(println (less Lst))

(println
   (filter
      '((A) (= 3 (length A)))
   (by
      '((W)
         (cons (length W) (sort (mapcar char W))))
      group
      Lst )
   )
)

(msg 'ok)
(bye)
