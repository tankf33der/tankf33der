(load "kangaroo12.l")

(test
   "1AC2D450FC3B4205D19DA7BFCA1B37513C0803577AC7167F06FE2CE1F0EF39E5"
   (kangaroo12_hex NIL NIL 32) )
(test
   "1AC2D450FC3B4205D19DA7BFCA1B37513C0803577AC7167F06FE2CE1F0EF39E54269C056B8C82E48276038B6D292966CC07A3D4645272E31FF38508139EB0A71"
   (kangaroo12_hex NIL NIL 64) )

(setq Tests
   (make
      (do 20
         (chain (range 0 `(hex "FA")) ) ) ) )
(test
   "2BDA92450E8B147F8A7CB629E784A058EFCA7CF7D8218E02D345DFAA65244A1F"
   (kangaroo12_hex (head (** 17 0) Tests) NIL 32) )
(test
   "6BF75FA2239198DB4772E36478F8E19B0F371205F6A9A93A273F51DF37122888"
   (kangaroo12_hex (head (** 17 1) Tests) NIL 32) )
(test
   "0C315EBCDEDBF61426DE7DCF8FB725D1E74675D7F5327A5067F367B108ECB67C"
   (kangaroo12_hex (head (** 17 2) Tests) NIL 32) )
(test
   "CB552E2EC77D9910701D578B457DDF772C12E322E4EE7FE417F92C758F0D59D0"
   (kangaroo12_hex (head (** 17 3) Tests) NIL 32) )
(test
   "B766201E84A743493BDDDCC87A6EAABB136E0C00F2420C9C21C654C35111F373"
   (kangaroo12_hex
      (mapcar char (chop "abc"))
      (mapcar char (chop "abc"))
      32 ) )
(test
   "CEC21190C33A30ED2A1A7956530FEDC2CABD6812309C7AE518E730D16D08A23F"
   (kangaroo12_hex
      (need 2600 0)
      (mapcar char (chop "abc"))
      32 ) )
(test
   "E7812ACA81EEC0B1DD975E410B992F1EEDB523B620DD5F8D55B5E63D2F9E7B2D"
   (kangaroo12_hex
      (need 16000 0)
      (mapcar char (chop "abc"))
      32 ) )
(test
   "0E9F39400B6D44194A5E19AA464E50F388BECC73E20A37635DE1F9DEE08C0359"
   (kangaroo12_hex
      (need 32000 0)
      (mapcar char (chop "abc"))
      32 ) )
(test
   "1CFC406B5133B234E81D1E1D03E1F95107D2ED02E64AAAF44F0ACA449D42CE1F"
   (kangaroo12_hex
      (need 32000 255)
      (need 32000 255)
      32 ) )
# Passed, long
#{
(in "tests/kangaroo-K12.dat"
   (until (eof)
      (and
         (test
            (kangaroo12_hex 
               (make (do (format (till ":" T)) (chain (copy (97 98 99)))))
               (97 98 99)
               16 )
            (prog (char) (line T)) ) ) ) )
}#
(msg 'OK-test-Kangaroo12)
