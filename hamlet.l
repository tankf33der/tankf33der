(load "hash/xxhash.l")
(de hash32 (S)
   (xxhash32
      (mapcar char (chop S)) ) )
(off H)
(for
   File
   (quote 
      "txt/Hamlet.txt" 
      "txt/alls-well-that-ends-well.txt"
      "txt/the-essays.txt" 
      "txt/the-new-atlantis.txt" 
      "txt/words.txt" )
   (in File
      (until (eof)
         (and
            (setq @@ (lowc (till "`)(}{\;:!?&-][,. ^J" T)))
            (idx 'H (cons (hash32 @@) @@) T) )
         (char) ) ) )
(println
   (bench
      (lup H (hash32 "eskimo"))) )
(msg 'ok)
(bye)

