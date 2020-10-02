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

(setq *Split 1234567)
(println (nextSplit))
(println (nextSplit))
(println (nextSplit))
(println (nextSplit))
(println (nextSplit))

(msg 'ok)
(bye)
