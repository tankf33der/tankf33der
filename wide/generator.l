(de ranges NIL
   (make
      (in '(bash -c "curl --silent http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt \
            | grep \"\;W\" | egrep -v \"^\#|reserved\"")
         (until (eof)
            (let R (split (till ";") ".")
               (link
                  (cons
                     (hex (pack (car R)))
                     (hex (pack ((if (cdr R) caddr car) R))) ) ) )
            (line) ) ) ) )
(de prRange (L)
   (space 12)
   (print L)
   (prin "  # " (hex (car L)) ".." (hex (cdr L)))
   (prinl) )
(let Lst (ranges)
   (test 225 (length Lst))
   (let X (car Lst)
      (for Y (cdr Lst)
         (if (>= (cdr X) (dec (car Y)))
            (setq X (cons (car X) (cdr Y)))
            (prRange X)
            (setq X Y) ) )
      (prRange X) ) )
(bye)
