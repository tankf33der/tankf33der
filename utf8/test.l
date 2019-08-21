(let S 0
   (in "1wOx"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 201751) )
(let S 0
   (in "UTF-8-demo.txt"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 20832567) )
(let S 0
   (in "0-0x10ffff_assigned_printable.txt"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 146517842895) )
(let S 0
   (in "utf8.html"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 21199166) )
(let S 0
   (in "unicode-sample.html"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 83058779) )
(let S 0
   (in "unicode-sample-3-2.html"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 555661087) )
(let S 0
   (in "armenia8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 171882) )
(let S 0
   (in "banviet8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 495889) )
(let S 0
   (in "calblur8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 4329689) )
(let S 0
   (in "croattx8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 48324) )
(let S 0
   (in "danish8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 154298) )
(let S 0
   (in "esperan8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 87872) )
(let S 0
   (in "huseyin8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 88296) )
(let S 0
   (in "jpndoc8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 8600848) )
(let S 0
   (in "kordoc8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 764394) )
(let S 0
   (in "linjilu8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 115540750) )
(let S 0
   (in "maopoem8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 730705) )
(let S 0
   (in "neural8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 1642868) )
(let S 0
   (in "russmnv8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 557173) )
(let S 0
   (in "sample68.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 3848063) )
(let S 0
   (in "tongtws8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 671623) )
(let S 0
   (in "ulysses8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 59039450) )
(let S 0
   (in "unilang8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 751747) )
(let S 0
   (in "zenbibl8.htm"
      (until (eof)
         (inc 'S (char (char))) ) )
   (test S 93696391) )

(msg 'OK-UTF8)
