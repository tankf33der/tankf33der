(in "eddsa_test.csv"
   (until (eof)
      (let
         (P (prog1 (till ",") (char) (from ","))
            M (prog1 (till ",") (char))
            S (prog1 (till ",") (char))
            R (if (=0 (format (line))) "00" "ff") )
         (when (= 128 (length S))
            (prinl P ':)
            (prinl M ':)
            (prinl S ':)
            (prinl R ':)
            (prinl) ) ) ) )
(bye)
