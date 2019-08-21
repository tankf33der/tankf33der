(load "hash-core.l")

(de sipround NIL
   (setq
      "V0" (mod64+ "V0" "V1")
      "V2" (mod64+ "V2" "V3")
      "V1" (rol64 "V1" 13)
      "V3" (rol64 "V3" 16)
      "V1" (x| "V1" "V0")
      "V3" (x| "V3" "V2")
      "V0" (rol64 "V0" 32)
      "V2" (mod64+ "V1" "V2")
      "V0" (mod64+ "V0" "V3")
      "V1" (rol64 "V1" 17)
      "V3" (rol64 "V3" 21)
      "V1" (x| "V1" "V2")
      "V3" (x| "V3" "V0")
      "V2" (rol64 "V2" 32) ) )
(de siphash24 (L K)
   (or
      (= 16 (length K))
      (quit "key length") )
   (let 
      (Len (length L)
         K0 (endian (cut 8 'K))
         K1 (endian (cut 8 'K))
         "V0" (x| K0 `(hex "736F6D6570736575"))
         "V1" (x| K1 `(hex "646F72616E646F6D"))
         "V2" (x| K0 `(hex "6C7967656E657261"))
         "V3" (x| K1 `(hex "7465646279746573"))
         L 
         (conc
            (need
               (-
                  1
                  (* 8 (/ (+ Len 1 7) 8)) )
               L
               0 )
            (cons (% Len 256)) ) )
      (while (endian (cut 8 'L))
         (setq "V3" (x| "V3" @))
         (do 2
            (sipround) ) 
         (setq "V0" (x| "V0" @)) )
      (setq "V2" (x| "V2" `(hex "FF")))
      (do 4
         (sipround) )
      (let N (x| "V0" "V1" "V2" "V3")
         (make
            (do 8
               (link (& 255 N))
               (setq N (>> 8 N)) ) ) ) ) )

