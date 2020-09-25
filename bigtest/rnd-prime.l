# X power Y modulus N
(de **Mod (X Y N)
   (let M 1
      (loop
         (when (bit? 1 Y)
            (setq M (% (* M X) N)) )
         (T (=0 (setq Y (>> 1 Y)))
            M )
         (setq X (% (* X X) N)) ) ) )
(de prime? (N)
   (and
      (> N 3)
      (bit? 1 N)
      (let (Q (dec N)  N1 (dec N)  K 0  X)
         (until (bit? 1 Q)
            (setq
               Q (>> 1 Q)
               K (inc K) ) )
         (catch 'composite
            (do 8
               (loop
                  (setq X
                     (**Mod
                        (if (> 1000000 N)
                           (rand 2 (- N 2))
                           (/ N (rand 2 1024)) )
                        Q
                        N ) )
                  (T (or (=1 X) (= X N1)))
                  (T
                     (do K
                        (setq X (**Mod X 2 N))
                        (when (=1 X) (throw 'composite))
                        (T (= X N1) T) ) )
                  (throw 'composite) ) )
            (throw 'composite T) ) ) ) )
# generate prime
(de gen (L)
   (let
      N
      (bin
         (pack
            (make
               (do (dec L)
                  (link (if (rand T) "1" "0")) )
               (link "1") ) ) )
      (until (prime? N)
         (inc 'N 2) )
      N ) )
(de rnd NIL
   (let B (gen (rand 16 128))
      (if (rand T) B (- B)) ) )
