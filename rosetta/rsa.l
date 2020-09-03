# http://rosettacode.org/wiki/RSA_code
(de **Mod (X Y N)
   (let M 1
      (loop
         (when (bit? 1 Y)
            (setq M (% (* M X) N)) )
         (T (=0 (setq Y (>> 1 Y)))
            M )
         (setq X (% (* X X) N)) ) ) )
(de int (Lst)
   (apply
      |
      (mapcar
         >>
         (range (* -8 (dec (length Lst))) 0 8)
         Lst ) ) )
(test
   9339818067420603508647824643763706884124019
   (**Mod
      (int (mapcar char (chop "ABCDEFGHIJKLMN123")))
      65537
      9516311845790656153499716760847001433441357 ) )
(msg 'rsa-OK)
