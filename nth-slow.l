(seed (in "/dev/urandom" (rd 8)))

(setq N 256)
(setq L (need N 0))
(bench
   (do (* 4 4000000)
      (nth L (rand 1 N)) ) )

(setq 
   B
   (make
      (for X N
         (link (cons X 0)) ) ) )
(balance 'Tree B)
(bench
   (do (* 4 4000000)
      (lup Tree (rand 1 N)) ) )

(msg 'ok)
(bye)
