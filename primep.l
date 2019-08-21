# http://rosettacode.org/wiki/Miller%E2%80%93Rabin_primality_test#PicoLisp
(de longRand (N)
   (use (R D)
      (while (=0 (setq R (abs (rand)))))
      (until (> R N)
         (unless (=0 (setq D (abs (rand))))
            (setq R (* R D)) ) )
      (% R N) ) )
(de **Mod (X Y N)
   (let M 1
      (loop
         (when (bit? 1 Y)
            (setq M (% (* M X) N)) )
         (T (=0 (setq Y (>> 1 Y)))
            M )
         (setq X (% (* X X) N)) ) ) )
(de _prim? (N D S)
   (use (A X R)
      (while (> 2 (setq A (longRand N))))
      (setq R 0  X (**Mod A D N))
      (loop
         (T
            (or
               (and (=0 R) (= 1 X))
               (= X (dec N)) )
            T )
         (T
            (or
               (and (> R 0) (= 1 X))
               (>= (inc 'R) S) )
            NIL )
         (setq X (% (* X X) N)) ) ) )
(de prime? (N K)
   (default K 50)
   (and
      (> N 1)
      (bit? 1 N)
      (let (D (dec N)  S 0)
         (until (bit? 1 D)
            (setq
               D  (>> 1 D)
               S  (inc S) ) )
         (do K
            (NIL (_prim? N D S))
            T ) ) ) )
# https://cr.yp.to/ecdh/curve25519-20051115.pdf
# Appendix B
(test T (prime? (- (** 2 255) 19)))
(test T (prime? (+ (** 2 252) 27742317777372353535851937790883648493)))
(test T (prime? (- (** 2 253) 55484635554744707071703875581767296995)))
(msg 'ok)
(bye)
