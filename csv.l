(de row NIL
   (let (F NIL  @@)
      (make
         (loop
            (T (eof))
            (T (unless F (= "^J" (peek)))
               (link (pack (flip @@))) 
               (char) )
            (case (peek)
               (","
                  (if F
                     (push '@@ (char))
                     (link (pack (flip @@)))
                     (off F @@)
                     (char) ) )
               ((" " "^M")
                  (if F (push '@@ (char)) (char)) )
               ("\""
                  (ifn F
                     (prog (on F) (char))
                     (char)
                     (if (= "\"" (peek))
                        (push '@@ (char))
                        (off F) ) ) )
               (T (push '@@ (char))) ) ) ) ) )
(de csv (File)
   (in File (make (while (row) (link @)))) )
(test
   '(("1" "22" "333") ("x" "y" NIL) ("aa" "bb" "cc"))
   (csv "csv-data/file1") )
(test
   '(("1" "2" "mike") ("2" "333" "mike \"world") ("1a1" "222" "mike1"))
   (csv "csv-data/file2") )
(test
   '(("1" "2" "3") ("m, " "abc" "m^M^Jike^M^J1"))
   (csv "csv-data/file3") )
(test
   '("1/2/0913:08" "Product1" "1200" "Mastercard" "FedericaeAndrea" 
      "Astoria" "OR" "UnitedStates" "1/1/0916:21" "1/3/0912:32" "46.18806" "-123.83" )
   (last (csv "csv-data/file4")) )
(let R (csv "csv-data/file5")
   (test
      '("id" "first_name" "last_name" "email" "gender" "ip_address" "SSN")
      (car R) )
   (test
      '("1000" "Lyn" "Gossart" "lgossartrr@artisteer.com" "Female" "172.12.170.64" "640-12-2088")
      (last R) ) )

(msg 'ok)
(bye)
