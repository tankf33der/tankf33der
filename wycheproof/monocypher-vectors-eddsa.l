(in "eddsa_test.csv"
   (until (eof)
      (prinl (prog1 (till ",") (char)) ':)
      (from ",")
      (prinl (prog1 (till ",") (char)) ':)
      (prinl (prog1 (till ",") (char)) ':)
      (prinl (if (=0 (format (line))) "00" "ff"))
      (prinl) ) )
(bye)
