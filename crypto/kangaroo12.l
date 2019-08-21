(load "keccak.l")

(de right_encode (N)
   (make
      (while (gt0 N)
         (yoke (% (swap 'N (/ N 256)) 256)) )
      (link (length (made))) ) )
(de kangaroo12 (I C O)
   (let
      (I (append I C (right_encode (length C)))
         B 8192
         N (/ (dec (+ (length I) B)) B) )
      (setq I
         (make (while I (link (cut B 'I)))) )
      (ifn (cdr I)
         (keccak 1344 256 (car I) `(hex "7") O NIL 12)
         (keccak
            1344
            256
            (append
               (car I)
               (need -8 (3) 0)
               (mapcan
                  '((L) (keccak 1344 256 L `(hex "B") 32 NIL 12))
                  (cdr I) )
               (right_encode (dec N))
               (need 2 255) )
            `(hex "6")
            O
            NIL
            12 ) ) ) )
(de kangaroo12_hex (I C O)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (kangaroo12 I C O) ) ) )

