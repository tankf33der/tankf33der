(de parse4forth (F)
   (in F
      (make
         (until (eof)
            (case (peek)
               ("(" (till ")") (char))
               ("\\" (line))
               (" " (skip))
               ("^J" (char))
               (T (link (intern (pack (till " ^J"))))) ) ) ) ) )
(test
   T
   (= 
      (parse4forth "parse/parse1")
      (parse4forth "parse/parse2")
      (parse4forth "parse/parse3")
      (parse4forth "parse/parse4")
      (parse4forth "parse/parse5") ) )
(de word ()
   (and
      (loop
         (T (eof))
         (T
            (lst?
               (case (peek)
                  ("(" (till ")") (char))
                  ("\\" (line T))
                  (" " (skip))
                  ("^J" (char))
                  (T (setq @@ (till " ^J"))) ) )
            @@ ) )
      (setq @@ @)
      ((if (fully format @@) format intern) (pack @@)) ) )
(de ffd (F)
   (in F
      (while (setq @@ (word))
         (and
            (num? @@)
            (println 'word @@) ) ) ) )
(ffd "parse/parse2")


(msg 'ok)
(bye)
