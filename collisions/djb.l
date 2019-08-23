(gc 128)
(de djb (L)
   (let H 5381
      (for N L
         (setq H (+ N (* 33 H))) )
      (& H `(hex "FFFFFFFF")) ) )
(off R)
(in "words_alpha.txt"
   (line)
   (while (line)
      (let
         (L (mapcar char @)
            H (djb L) )
         (ifn (lup R H)
            (idx 'R (list H 1 (cons L)) T)
            (inc (cdr @))
            (push (cddr @) L) ) ) ) )
(for L (idx 'R)
   (and
      (> (cadr L) 1)
      (prin (align 10 (car L)) ": ")
      (for I (caddr L)
         (prin (mapcar char I)) )
      (prinl)
   )
)
(msg 'ok)
(bye)
