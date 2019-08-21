(load "rc2.l")

(de hex2L (H)
   (let H (chop H)
      (make
         (while (cut 2 'H)
            (link (hex (pack @))) ) ) ) )
(use (I K C)
   (in "tests/rc2.vec"
      (until (eof)
         (and
            (from "Key = ")
            (setq K (hex2L (line)))
            (from "In = ")
            (setq I (hex2L (line)))
            (from "Out = ")
            (setq C (hex2L (line)))
            #(println K I C)
            (test C (rc2 I K )) ) ) ) )
(msg 'OK-test-RC2)
