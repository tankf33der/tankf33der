(load "bcrypt-blowfish.l")

(de hex2L (H)
   (make
      (for (L H L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
# key bytes clear bytes cipher bytes
(in "tests/Blowfish.txt"
   (until (eof)
      (let L (mapcar hex2L (split (chop (line T)) " "))
         #(println 'L L)
         (test (caddr L) (bl (cadr L) (car L))) ) ) ) 

# data, result, key
(use (D)
   (in "tests/Blowfish2.txt"
      (let D (hex2L (chop (line T)))
         (until (eof)
            (let L (mapcar hex2L (split (chop (line T)) ","))
               #(println 'L L)
               (test (car L) (bl D (cadr L))) ) ) ) ) )
(msg 'OK-test-Blowfish)
