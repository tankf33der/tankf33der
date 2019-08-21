(de padd (Lst)
   (let
      (Len (length Lst)
         Lst
         (conc
            (need
               (-
                  9
                  (* 64 (/ (+ 2 8 Len 63) 64)))
               (append Lst (cons `(hex "80")))
               0 )
            (cons 1)
            (flip
               (make
                  (setq Len (* 8 Len))
                  (do 8
                     (link (& Len 255))
                     (setq Len (>> 8 Len )) ) ) ) ) )
   (println (length Lst)) 
   (while Lst
      (println (cut 64 'Lst)) ) ) )

# 64, 128, 192, ...
(de simpl (Lst)
   (let Len (length Lst)
      (append
         Lst
         (need 
            (-
               (* 64 (/ (+ Len 63) 64))
               Len )
            0 ) ) ) )
(and
   (simpl (range 1 65))
   (test 128 (length @)) )
(and
   (simpl (range 1 43))
   (test 64 (length @)) )

(de simpl2 (Lst)
   (let (Len (length Lst)  Y Len)
      (while (> Y 55)
         (dec 'Y 64) )
      (setq Lst
         (append
            Lst
            (if (= 55 Y)
               (cons 129)
               (conc
                  (cons 128)
                  (need
                     (- 
                        (* 64 (/ (+ 2 8 Len 63) 64))
                        9
                        Len )
                     (cons 1)
                     0 ) ) )
            (flip
               (make
                  (setq Len (* 8 Len))
                  (do 8
                     (link (& Len 255))
                     (setq Len (>> 8 Len)) ) ) ) ) ) 
      Lst ) )
(and
   (simpl2 (range 1 60))
   (println (length @) @) )

# 53 - 0
# 54 - no zeros
# 55 - second padd
# 63 - full first padd
# 64 - 0x80 in start of second padd
# 65 - rest!
#(padd (range 1 55))
(bye)

