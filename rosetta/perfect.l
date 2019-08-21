(de faster (N)
   (let (C 1  Stop (sqrt N))
      (for (I 2 (<= I Stop) (inc I))
         (and
            (=0 (% N I))
            (inc 'C (+ (/ N I) I)) ) )
      (= C N) ) )
(bench
   (for (I 33540000 (<= I 33551000) (inc I))
      (and (faster I) (println I)) ) )
(bench
   (for (I 2 (<= I 10000) (inc I))
      (and (faster I) (println I)) ) )
(bye)


