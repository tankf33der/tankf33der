(setq 
   *BLAKE2B-IV
   `(mapcar
      hex
      (quote
         "6A09E667F3BCC908" "BB67AE8584CAA73B"
         "3C6EF372FE94F82B" "A54FF53A5F1D36F1"
         "510E527FADE682D1" "9B05688C2B3E6C1F"
         "1F83D9ABFB41BD6B" "5BE0CD19137E2179" ) )
   *BLAKE2B-S
   (quote
      (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)
      (15 11 5 9 10 16 14 7 2 13 1 3 12 8 6 4)
      (12 9 13 1 6 3 16 14 11 15 4 7 8 2 10 5)
      (8 10 4 2 14 13 12 15 3 7 6 11 5 1 16 9)
      (10 1 6 8 3 5 11 16 15 2 12 13 7 9 4 14)
      (3 13 7 11 1 12 9 4 5 14 8 6 16 15 2 10)
      (13 6 2 16 15 14 5 11 1 8 7 4 10 3 9 12)
      (14 12 8 15 13 2 4 10 6 1 16 5 9 7 3 11)
      (7 16 15 10 12 4 1 9 13 3 14 8 2 5 11 6)
      (11 3 9 5 8 7 2 6 16 12 10 15 4 13 14 1)
      (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)
      (15 11 5 9 10 16 14 7 2 13 1 3 12 8 6 4) ) )
(de mod64 (N)
   (& N `(hex "FFFFFFFFFFFFFFFF")) )
(de not64 (N)
   (x| N `(hex "FFFFFFFFFFFFFFFF")) )
(de add64 @
   (mod64 (pass +)) )
(de ror64 (X C)
   (| (>> C X) (mod64 (>> (- C 64) X))) )
(de endian (L) # little
   (apply
      |
      (mapcar >> (0 -8 -16 -24 -32 -40 -48 -56) L) ) )
(de _G (A B C D X Y)
   (let
      (VA (get V A)
         VB (get V B)
         VC (get V C)
         VD (get V D)
         VA (add64 VA VB X)
         VD (ror64 (x| VD VA) 32)
         VC (add64 VC VD)
         VB (ror64 (x| VB VC) 24)
         VA (add64 VA VB Y)
         VD (ror64 (x| VD VA) 16)
         VC (add64 VC VD)
         VB (ror64 (x| VB VC) 63) ) 
         (set
            (nth V A) VA
            (nth V B) VB
            (nth V C) VC
            (nth V D) VD ) ) )
(de blake2b (Lst Out)
   (default Out 64)
   (let
      (Len (length Lst)
         Lst
         (if Lst
            (need
               (* -128 (/ (+ Len 127) 128))
               (copy Lst)
               0 )
            (need 128 0) )
         H (copy *BLAKE2B-IV)
         C 0 )
      (set H 
         (x| (car H) `(hex "1010000") Out) )
      (while Lst
         (let
            (M 
               (make
                  (do 16
                     (link (endian (cut 8 'Lst))) ) )
               V (conc (copy H) (copy *BLAKE2B-IV)) )
            (if (< Len 128) # XXX
               (inc 'C (swap 'Len 0))
               (inc 'C 128) 
               (dec 'Len 128) )
            (set
               (nth V 13) (x| (get V 13) (mod64 C))
               (nth V 14) (x| (get V 14) (>> 64 C)) )
            (and
               (=0 Len)
               (set (nth V 15) (not64 (get V 15))) )
            (for S *BLAKE2B-S
               (let MS (mapcar '((I) (get M I)) S)
                  (_G 1 5  9 13 (++ MS) (++ MS))
                  (_G 2 6 10 14 (++ MS) (++ MS))
                  (_G 3 7 11 15 (++ MS) (++ MS))
                  (_G 4 8 12 16 (++ MS) (++ MS))
                  (_G 1 6 11 16 (++ MS) (++ MS))
                  (_G 2 7 12 13 (++ MS) (++ MS))
                  (_G 3 8  9 14 (++ MS) (++ MS))
                  (_G 4 5 10 15 (++ MS) (++ MS)) ) )
            (let (LH (head 8 V)  LT (tail 8 V))
               (for (L H L)
                  (set L
                     (x| (++ L) (++ LH) (++ LT)) ) ) ) ) )
            (let C (circ 0 8 16 24 32 40 48 56)
               (head
                  Out
                  (make
                     (for N H
                        (do 8
                           (link (& (>> (++ C) N) `(hex "FF"))) ) ) ) ) ) ) )
(de blake2b_hex (L O)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (blake2b L O) ) ) )
#{
(test 
   (89 41 133 48 237)
   (blake2b (1 2 3) 5) )
(test
   (207 148 246 214 5 101 126 144 197 67 176 201 25 7 12 218 175 114 9 197 225 234 88 172 184 243 86 143 162 17 66 104 220 154 195 186 254 18 175 39 125 40 111 206 125 197 155 124 12 52 137 115 196 233 218 203 231 148 133 229 106 194 167 2)
   (blake2b (1 2 3)) )
}#
