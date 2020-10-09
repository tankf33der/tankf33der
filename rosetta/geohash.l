(scl 20)
(setq *GBASE32 (chop "0123456789bcdefghjkmnpqrstuvwxyz"))
(de encode (Lat Lng Prec)
   (let Lst
      (mapcar
         '((A B C)
            (let M (/ (sum prog B) 2)
               (if (> C M)
                  (prog (set B M) 1)
                  (set (cdr B) M)
                  0 ) ) )
         (range 1 (* 5 Prec))
         # Longitude, Latitude
         (circ (list -180.0 180.0) (list -90.0 90.0))
         (circ Lng Lat) )
      (pack
         (make
            (for (L Lst L)
               (link
                  (get
                     *GBASE32
                     (inc (bin (pack (cut 5 'L)))) ) ) ) ) ) ) )
(println (encode 51.433718 -0.214126 2))
(println (encode 51.433718 -0.214126 9))
(println (encode 57.649110 10.407440 11))

(test "gc" (encode 51.433718 -0.214126 2))
(test "gcpue5hp4" (encode 51.433718 -0.214126 9))
(test "u4pruydqqvj" (encode 57.649110 10.407440 11))


(msg 'ok)
(bye)
