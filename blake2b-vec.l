(in "crypto/tests/blake2b-kat.txt"
   (until (eof)
      (and
         (from "in:")
         (char)
         (prinl (line) ":")
         (from "key:")
         (char)
         (prinl (line) ":")
         (from "hash:")
         (char)
         (prinl (line) ":")
         (prinl) ) ) )
(bye)
