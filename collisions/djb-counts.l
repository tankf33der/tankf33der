(gc 100)
(de djb (L)
   (let H 5381
      (for N L
         (setq H (+ N (* X H))) )
      (& H `(hex "FFFFFFFF")) ) )
(setq Lst
   (make
      (in "words_alpha.txt"
         (line)
         (while (line)
            (link (mapcar char @)) ) ) ) )
(for X 255
   (let R NIL
      (for L Lst
         (let H (djb L)
            (if (lup R H)
               (inc (cdr @))
               (idx 'R (list H 1) T) ) ) )
      (println
         X
         (cnt
            '((L) (> (cadr L) 1))
            (idx 'R) ) ) ) )
(msg 'ok)
(bye)
