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
      (let (Q (dec N) K 0  X 0  N1 (dec N))
         (until (bit? 1 Q)
            (setq
               Q (>> 1 Q)
               K (inc K) ) )
         (println 'Q Q 'K K)

      )
   )
)

(println (prime? 2207))
(println (prime? 2209))


(msg 'ok)
(bye)

