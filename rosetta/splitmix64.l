(de mod64 (N)
   (& N `(hex "FFFFFFFFFFFFFFFF")) )
(de mod64+ (A B)
   (mod64 (+ A B)) )
(de mod64* (A B)
   (mod64 (* A B)) )

(zero *Split)
(de nextSplit ()
   (setq *Split
      (mod64+ *Split `(hex "9e3779b97f4a7c15")) )
   (let Z *Split
      (setq
         Z
         (mod64*
            `(hex "bf58476d1ce4e5b9")
            (x| Z (>> 30 Z)) )
         Z
         (mod64*
            `(hex "94d049bb133111eb")
            (x| Z (>> 27 Z)) ) )
      (x| Z (>> 31 Z)) ) )

(scl 12)
(setq *Split 987654321)
(off R)
(do 20
   (set
      'N
      (*
         5
         (*/ (nextSplit) 1.0 18446744073709551616) ) )
   (println N (round N 0))
)

(msg 'ok)
(bye)
