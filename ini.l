# limitations:
# o) comments only ; char
# o) pairs only under [header]
(de ini-read (F)
   (in F
      (make
         (while (from "[")
            (link 
               (list
                  (intern (pack (clip (till "]"))))
                  (prog
                     (line T)
                     (make
                        (until (or (= "[" (peek)) (eof))
                           (skip ";")
                           (link
                              (cons
                                 (intern (pack (clip (till "="))))
                                 (prog (char) (pack (clip (till ";^J")))) ) )
                           (skip ";") ) ) ) ) ) ) ) ) )
(de ini-get (R . @)
   (while (rest)
      (setq R (cadr (asoq (next) R))) )
   R )

(test
   '((protocol ((version . "6"))))
   (ini-read "ini-data/demo0.ini") )

(setq INI (ini-read "ini-data/demo1.ini"))
(test
   '((name . "Bob Smith") (email . "bob@smith.com") (active . "true") (age . "33"))
   (ini-get INI 'user) )
(test
   "33"
   (ini-get INI 'user 'age) )

(setq INI (ini-read "ini-data/demo2.ini"))
(test
   "1"
   (ini-get INI 'SNMP 'UseSNMP) )

(setq INI (ini-read "ini-data/demo3.ini"))
(test
   "{721C0EA1-8ABD-4516-997D-36AA465369E6}"
   (ini-get INI 'DriverConfig 'PrinterDriverID) )

(msg 'INI-ok)
(bye)

