(seed (in "/dev/urandom" (rd 8)))
(load "bcrypt-blowfish.l")

(de bcrypt (K S)
   (default
      K (128) 
      S (make (do 16 (link (rand 0 255)))) )
   (let
      ("B"
         (mapcar
            '((L) (copy (val L)))
            '(*P-Init *S0-Init *S1-Init *S2-Init *S3-Init) )
         M1 (79 114 112 104 101 97 110 66)
         M2 (101 104 111 108 100 101 114 83)
         M3 (99 114 121 68 111 117 98 116) )
      (bexs '"B" K S)
      (do 256 # 2^8
         (bex '"B" K)
         (bex '"B" S) )
      (for L '(M1 M2 M3)
         (do 64
            (set L (benc '"B" (val L))) ) )
      (list (append M1 M2 M3) S) ) )
        
