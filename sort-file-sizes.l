(de _@norm (Lst)
   (and
      (= '/ (car Lst))
      (for (L Lst L (cdr L))
         (NIL (= '/ (cadr L)) L) ) ) ) 
(de _$norm (Lst)
   (and
      (cdr Lst)
      (for (L (flip Lst) L (cdr L))
         (NIL (= '/ (car L)) L) ) ) )
(de norm (Str)
   (and
      (_@norm (chop Str))
      (pack (flip (_$norm @))) ) )
(test
   T
   (=
      NIL
      (norm)
      (norm "/")
      (norm "//")
      (norm "///")
      (norm "mike")
      (norm "mike/") ) )
(test
   T
   (=
      "/mike"
      (norm "/mike")
      (norm "//mike")
      (norm "/mike/")
      (norm "//mike//") ) )

(de file&size (Dir)
   (let? Dir (norm Dir)
      (head
         5
         (flip
            (sort
               (mapcan
                  '((F)
                     (and
                        (num? (car (info F)))
                        (cons (cons @ F)) ) ) 
                  (mapcar
                     '((N) (pack Dir '/ N)) 
                     (dir Dir) ) ) ) ) ) ) )
(println (file&size "/root"))
(msg 'ok)
(bye)

