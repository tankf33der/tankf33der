(in "x25519_test.csv"
   (until (eof)
      (prinl (prog1 (till ",") (char)) ':)
      (prinl (prog1 (till ",") (char)) ':)
      (prinl (line) ':)
      (prinl) ) )
(bye)
