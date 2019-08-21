(seed (in "/dev/urandom" (rd 8)))

(de nth-haha (N)
   (let Lst (need N 0)
      (do (* N N)
         (inc (nth Lst (rand 1 N))) ) ) )

(de cache-hehe (N)
   (let C NIL
      (for I N
         (cache 'C I (rand 1 N)) )
      (do (* N N)
         (inc (cache 'C (rand 1 N))) ) ) )

(bench (nth-haha 1000))
(bench (nth-haha 2000))
(bench (nth-haha 3000))

(bench (cache-hehe 1000))
(bench (cache-hehe 2000))
(bench (cache-hehe 3000))

(bye)
