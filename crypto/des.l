(load "des-const.l")

(de hex2L (L)
   (make
      (while (cut 2 'L)
         (link (hex (pack @))) ) ) )
(de bin64 (L)
   (mapcan
      '((N)
         (chop (pad 8 (bin N))) )
      L ) )
(de rotate (L N)
   (append (nth L (inc N)) (head N L)) )

(setq K (bin64 (hex2L (chop "133457799BBCDFF1"))))
(setq KK
   (mapcar
      '((I) (get K I))
      *PC1 ) )

(setq
   C (head 28 KK)
   D (tail 28 KK) )
(println 'C C)
(println 'D D)
(setq C1
   (make
      (mapc
         '((S)
            (link (pack (setq C (rotate C S)))) )
         *SHIFTS ) ) )
(mapc
   println
   C1 )


(msg 'ok)
(bye)
