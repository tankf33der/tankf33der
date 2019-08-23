(de djb (L)
   (let H 5381
      (for N L
         (setq H (+ N (* 33 H))) )
      (& H `(hex "FFFFFFFF")) ) )
(off R)
#{
(in "words_alpha.txt"
   (line)
   (do 1000
      (accu 'R (djb (mapcar char (line))) 1)
   )
   (println (filter '((L) (> (cdr L) 1)) R))
)
}#
(msg 'ok)
(bye)
