(load "threefish.l")

# Skein-256-256 (v 1.3)
(de skein256 (Lst)
   (let
      (Pos 0 
         Key (copy (18202890402666165321 3443677322885453875 12915131351309911055 7662005193972177513)) )
      (while (cut 32 'Lst)
         (let 
            (Tweak (list (setq Pos (mod64+ Pos (length @))) `(>> -56 48))
               Msg NIL )
            (need -32 @ 0)
            (setq Msg
               (make
                  (do 4
                     (link (endian (cut 8 '@))) ) ) )
            (and
               (>= 32 Pos)
               (set (cdr Tweak) (x| (cadr Tweak) `(>> -62 1))) )
            (or
               Lst
               (set (cdr Tweak) (x| (cadr Tweak) `(>> -63 1))) )
            (threefish256 Msg 'Key Tweak)
            (map
               '((K L)
                  (set K (x| (car K) (car L))) )
               Key
               Msg ) ) )
      (let Tweak (list 8 (x| (>> -56 63) (>> -62 3)))
         (threefish256 (need 4 0) 'Key Tweak) )
      (mapcan
         '((N)
            (make
               (do 8
                  (link (& 255 N))
                  (setq N (>> 8 N)) ) ) )
         Key ) ) )
