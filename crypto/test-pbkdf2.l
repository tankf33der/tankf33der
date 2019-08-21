(load "../rosetta/sha1.l")
(load "../rosetta/sha256.l")
(load "pbkdf2.l")

# RFC6070
(setq "L"
   (pbkdf2
      'sha1
      (mapcar char (chop "password"))
      (mapcar char (chop "salt"))
      1
      20 ) )
(test
   T
   (and (= `(hex "0C") (car "L")) (= `(hex "A6") (last "L"))) )

(setq "L"
   (pbkdf2
      'sha1
      (mapcar char (chop "password"))
      (mapcar char (chop "salt"))
      2
      20 ) )
(test
   T
   (and (= `(hex "EA") (car "L")) (= `(hex "57") (last "L"))) )

(setq "L"
   (pbkdf2
      'sha1
      (mapcar char (chop "password"))
      (mapcar char (chop "salt"))
      4096
      20 ) )
(test
   T
   (and (= `(hex "4B") (car "L")) (= `(hex "C1") (last "L"))) )

(setq "L"
   (pbkdf2
      'sha1
      (mapcar char (chop "passwordPASSWORDpassword"))
      (mapcar char (chop "saltSALTsaltSALTsaltSALTsaltSALTsalt"))
      4096
      25 ) )
(test
   T
   (and (= `(hex "3D") (car "L")) (= `(hex "38") (last "L"))) )

# Internet
(setq "L"
   (pbkdf2
      'sha256
      (mapcar char (chop "passwordPASSWORDpassword"))
      (mapcar char (chop "saltSALTsaltSALTsaltSALTsaltSALTsalt"))
      4096
      40 ) )
(test
   T
   (and (= `(hex "34") (car "L")) (= `(hex "E9") (last "L"))) )

(msg 'OK-test-pbkdf2)

