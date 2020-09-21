(seed (in "/dev/urandom" (rd 8)))

# first prime? ecosystem from PicoLisp lib/rsa.l
#
# Generate long random number
(de longRand (N)
   (use (R D)
      (while (=0 (setq R (abs (rand)))))
      (until (> R N)
         (unless (=0 (setq D (abs (rand))))
            (setq R (* R D)) ) )
      (% R N) ) )

# X power Y modulus N
(de **Mod (X Y N)
   (let M 1
      (loop
         (when (bit? 1 Y)
            (setq M (% (* M X) N)) )
         (T (=0 (setq Y (>> 1 Y)))
            M )
         (setq X (% (* X X) N)) ) ) )

# Probabilistic prime check
(de rsa-prime? (N)
   (and
      (> N 1)
      (bit? 1 N)
      (let (Q (dec N)  K 0)
         (until (bit? 1 Q)
            (setq
               Q  (>> 1 Q)
               K  (inc K) ) )
         (do 50
            (NIL (_prim? N Q K))
            T ) ) ) )

# (Knuth Vol.2, p.379)
(de _prim? (N Q K)
   (use (X J Y)
      (while (> 2 (setq X (longRand N))))
      (setq
         J 0
         Y (**Mod X Q N) )
      (loop
         (T
            (or
               (and (=0 J) (= 1 Y))
               (= Y (dec N)) )
            T )
         (T
            (or
               (and (> J 0) (= 1 Y))
               (<= K (inc 'J)) )
            NIL )
         (setq Y (% (* Y Y) N)) ) ) )
# ^^^ done

(de prime? (N)
   (and
      (> N 1)
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
                           (rand 2 N1)
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
# works
# (test T (prime? 2207))
# (test NIL (prime? 2209))
# (test T (rsa-prime? 999727))
# (test T (rsa-prime? 999809))
# (test T (rsa-prime? 999983))
# (test NIL (prime? 999999))
# (test T (prime? 4547337172376300111955330758342147474062293202868155909489))
# (test T (rsa-prime? 4547337172376300111955330758342147474062293202868155909489))
# (test NIL (prime? 4547337172376300111955330758342147474062293202868155909393))
# (test NIL (rsa-prime? 4547337172376300111955330758342147474062293202868155909393))
# (test T (prime? 643808006803554439230129854961492699151386107534013432918073439524138264842370630061369715394739134090922937332590384720397133335969549256322620979036686633213903952966175107096769180017646161851573147596390153))
# (test T (rsa-prime? 643808006803554439230129854961492699151386107534013432918073439524138264842370630061369715394739134090922937332590384720397133335969549256322620979036686633213903952966175107096769180017646161851573147596390153))
# (test NIL (prime? 743808006803554439230129854961492699151386107534013432918073439524138264842370630061369715394739134090922937332590384720397133335969549256322620979036686633213903952966175107096769180017646161851573147596390153))
# (test NIL (rsa-prime? 743808006803554439230129854961492699151386107534013432918073439524138264842370630061369715394739134090922937332590384720397133335969549256322620979036686633213903952966175107096769180017646161851573147596390153))

(de gen (L)
   (let
      N
      (bin
         (pack
            (make
               (do (dec L)
                  (link (if (rand T) "1" "0")) )
               (link "1") ) ) )
      (until (rsa-prime? N)
         (inc 'N 2) )
      N ) )
(for N (range 8 1024)
   (println 'N N)
   (do 512
      (let N (gen N)
         (test T (prime? N)) ) ) )

(msg 'ok)
(bye)

