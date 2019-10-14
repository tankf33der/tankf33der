(de hex2L (H)
   (make
      (for (L H L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(in "eddsa_test.csv"
   (until (eof)
      (prin "{ ")
      (do 3 (from ","))
      (prinl (glue "," (hex2L (till ","))))
      (line)
      
      (prinl "}") ) )
(bye)
