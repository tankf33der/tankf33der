(test
   (quote 12 : mike 1a2 $$ 1+ add a)
   (in "parse2list.dat"
      (make
         (while (skip "\\")
            (and
               (= "(" (peek))
               (till ")")
               (char)
               (skip "\\") )
            (let @@ (till " ^J")
               (link 
                  (if (fully format @@)
                     (format @@)
                     (intern (pack @@)) ) ) ) ) ) ) )
(msg 'OK-parse2list)
