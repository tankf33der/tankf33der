(load "hmac.l")

(de uint32 (N)
   (make
      (do 4
         (yoke (& N `(hex "FF")))
         (setq N (>> 8 N)) ) ) )
(de pbkdf2 ("Fun" Pwd Slt Itr Len)
   (let
      (Hlen (length ("Fun"))
         Blcks (/ (dec (+ Len Hlen)) Hlen) )
      (head
         Len
         (make
            (for B Blcks
               (let 
                  (Tr (hmac "Fun" (append Slt (uint32 B)) Pwd)
                     U (hmac "Fun" Tr Pwd) )
                  (for (N 2 (>= Itr N) (inc N))
                     (map
                        '((S D)
                           (set S (x| (car S) (car D))) )
                        Tr
                        U )
                     (setq U (hmac "Fun" U Pwd)) )
                  (chain Tr) ) ) ) ) ) )

