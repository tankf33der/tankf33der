(let
   (L (range 100 800 100)
      Dst (range 1 8) )
   (println 'Dst Dst)
   (map
      '((S D) (set D (+ (car D) (car S))))
      (head 4 L)
      Dst )
   (map
      '((S D) (set D (* (car D) (car S))))
      (tail 4 L)
      (nth Dst 5) )
   (println 'Dst Dst) )

(msg 'new)
(let (Lst1 (range 1 8)  Lst2 (range 21 28))
   (println Lst1 Lst2)
   (mapc
      '((Lst)
         (for (L (cdr (val Lst)) L (cddr L))
            (set L (* 100 (car L))) ) )
      '(Lst1 Lst2) )
   (println Lst1 Lst2) )


(msg 'new)
(let (Lst1 (111 2 3 4 5)  Lst2 (222 22 33 44 55))
   (println Lst1 Lst2)
   (map
      '((L1 L2) (xchg L1 L2))
      (cdr Lst1)
      (cdr Lst2) )
   (println Lst1 Lst2) )

(msg 'new)
(let (Lst1 (range 1 8)  Lst2 (range 21 28))
   (println Lst1 Lst2)
   (let (L1 (cdr Lst1)  L2 (cdr Lst2))
      (do 4
         (xchg L1 L2)
         (cut 2 'L1)
         (cut 2 'L2) ) )
   (println Lst1 Lst2) )

(msg 'new)
(de nn ("1" "3")
   (set
      "1" (+ 100 (car "1"))
      "3" (x| 22 (car "3")) ) )
(let Lst (range 1 8)
   (println 'Lst Lst)
   (nn
      (nth Lst 1)
      (nth Lst 3) )
   (println 'Lst Lst) )

(msg 'new)
(de xor64 (N)
   (x| N `(hex "FFFFFFFFFFFFFFFF")) )
(de SS (L C0 C1)
   (use (T0 T1)
      (set
         (nth L 7) (xor64 (get L 7))
         (nth L 8) (xor64 (get L 8))
         (nth L 1)
         (x|
            (get L 1)
            (& (xor64 (get L 5)) C0) )
         (nth L 2)
         (x|
            (get L 2)
            (& (xor64 (get L 6)) C1) )
         'T0 (x| C0 (& (get L 1) (get L 3)))
         'T1 (x| C1 (& (get L 2) (get L 4)))
         (nth L 1)
         (x|
            (get L 1)
            (& (get L 5) (get L 7)) )
         (nth L 2)
         (x|
            (get L 2)
            (& (get L 6) (get L 8)) )
         (nth L 7)
         (x|
            (get L 7)
            (& (xor64 (get L 3)) (get L 5)) )
         (nth L 8)
         (x|
            (get L 8)
            (& (xor64 (get L 4)) (get L 6)) )
         (nth L 3)
         (x|
            (get L 3)
            (& (get L 1) (get L 5)) )
         (nth L 4)
         (x|
            (get L 4)
            (& (get L 2) (get L 6)) )
         (nth L 5)
         (x|
            (get L 5)
            (& (get L 1) (xor64 (get L 7))) )
         (nth L 6)
         (x|
            (get L 6)
            (& (get L 2) (xor64 (get L 8))) )
         (nth L 1)
         (x|
            (get L 1)
            (| (get L 3) (get L 7)) )
         (nth L 2)
         (x|
            (get L 2)
            (| (get L 4) (get L 8)) )
         (nth L 7)
         (x|
            (get L 7)
            (& (get L 3) (get L 5)) )
         (nth L 8)
         (x|
            (get L 8)
            (& (get L 4) (get L 6)) )
         (nth L 3) (x| (get L 3) (& T0 (get L 1)))
         (nth L 4) (x| (get L 4) (& T1 (get L 2)))
         (nth L 5) (x| (get L 5) T0)
         (nth L 6) (x| (get L 6) T1) ) ) )
(de L (L)
   (set
      (nth L 2) (x| (get L 2) (get L 3))
      (nth L 4) (x| (get L 4) (get L 5))
      (nth L 6)
      (x|
         (get L 6)
         (get L 1)
         (get L 7) )
      (nth L 8) (x| (get L 8) (get L 1))
      (nth L 1) (x| (get L 1) (get L 4))
      (nth L 3) (x| (get L 3) (get L 6))
      (nth L 5)
      (x|
         (get L 5)
         (get L 2)
         (get L 8) )
      (nth L 7) (x| (get L 7) (get L 2)) ) )
(let L1 (111 221 331 441 551 661 771 881)
   (println 'L1 L1)
   (SS L1 1177 2277)
   (println 'L1 L1) )



(bye)
