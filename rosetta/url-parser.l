# opaque and empty host not supported
# well formed only
# without validations
# parser only


(de url (Lst)
   (let (Lst (chop Lst)  A 0  B 0)
      (make
         # scheme
         (link
            (list
               's
               (pack (cut (dec (index ":" Lst)) 'Lst)) ) )
         # ://
         (do 3
            (++ Lst) )
         # user[:pass]@
         (setq
            A (index "@" Lst)
            B (or (index "/" Lst) T) )
         (and
            (gt0 A)
            (> B A)
            (link
               (list 'u (pack (cut (dec A) 'Lst))) )
            (++ Lst) )
         # host[:port]
         (link
            (list
               'h
               (pack
                  (cut
                     (min
                        (or (dec (index "/" Lst)) T)
                        (length Lst) )
                     'Lst ) ) ) )
         # path
         (when Lst
            (link
               (list
                  'p
                  (pack
                     (cut
                        (min
                           (or (dec (index "?" Lst)) T)
                           (or (dec (index "#" Lst)) T)
                           (length Lst) )
                        'Lst ) ) ) )
            (++ Lst) )
         # query
         (when Lst
            (link
               (list
                  'q
                  (pack
                     (cut
                        (min
                           (or (dec (index "#" Lst)) T)
                           (length Lst) )
                        'Lst ) ) ) )
            (++ Lst) )
         # fragment
         (when Lst (link (list 'f (pack Lst)))) ) ) )

(test
   '((s "foo") (u "user") (h "example.com:8042") (p "/over/there") (q "name=ferret") (f "nose"))
   (url "foo://user@example.com:8042/over/there?name=ferret#nose") )
(test
   '((s "ftp") (h "ftp.is.co.za") (p "/rfc/rfc1808.txt"))
   (url "ftp://ftp.is.co.za/rfc/rfc1808.txt") )
(test
   '((s "http") (h "www.ietf.org") (p "/rfc/rfc2396.txt") (q "header1"))
   (url "http://www.ietf.org/rfc/rfc2396.txt#header1") )
(test
   '((s "ldap") (h "[2001:db8::7]") (p "/c=GB") (q "objectClass=one&objectClass=two"))
   (url "ldap://[2001:db8::7]/c=GB?objectClass=one&objectClass=two") )
(test
   '((s "telnet") (h "192.0.2.16:80") (p "/"))
   (url "telnet://192.0.2.16:80/") )
(test
   '((s "ssh") (u "alice") (h "example.com"))
   (url "ssh://alice@example.com") )
(test
   '((s "https") (u "bob:pass") (h "example.com") (p "/place"))
   (url "https://bob:pass@example.com/place") )
(test
   '((s "http") (h "example.com") (p "/") (q "a=1&b=2+2&c=3&c=4&d=%65%6e%63%6F%64%65%64"))
   (url "http://example.com/?a=1&b=2+2&c=3&c=4&d=%65%6e%63%6F%64%65%64") )
(test
   '((s "http") (h "mt0.google.com") (p "/vt/lyrs=m@114&hl=en&src=api&x=2&y=2&z=3&s="))
   (url "http://mt0.google.com/vt/lyrs=m@114&hl=en&src=api&x=2&y=2&z=3&s=") )
(test
   '((s "http") (h "sub.example.com") (p "/bar") (q "foo=bar") (f "hash"))
   (url "http://sub.example.com/bar?foo=bar#hash") )
(test
   '((s "https") (h "thisanurl.com") (p "/") (q "swag=yolo") (f "representing"))
   (url "https://thisanurl.com/?swag=yolo#representing") )
(test
   '((s "scheme") (h "!$&'()*+,;=hello!:port") (p "/path"))
   (url "scheme://!$&'()*+,;=hello!:port/path") )
(test
   '((s "http") (h "host") (p "/!$&'()*+,;=:@[hello]"))
   (url "http://host/!$&'()*+,;=:@[hello]") )
(test
   '((s "http") (u "rob:abcd1234") (h "www.domain.com") (p "/path/index.html") (q "query1=test&silly=willy") (f "test=hash&chucky=cheese"))
   (url "http://rob:abcd1234@www.domain.com/path/index.html?query1=test&silly=willy#test=hash&chucky=cheese") )
(msg 'ok)
(bye)
