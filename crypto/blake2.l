(setq 
   *BLAKE2B-IV
   (mapcar
      hex
      (quote
         "6A09E667F3BCC908" "BB67AE8584CAA73B"
         "3C6EF372FE94F82B" "A54FF53A5F1D36F1"
         "510E527FADE682D1" "9B05688C2B3E6C1F"
         "1F83D9ABFB41BD6B" "5BE0CD19137E2179" ) )
   *BLAKE2B-S
   (mapcar
      '((L) (mapcar inc L) )
      (quote   
         ( 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15) 
         (14 10  4  8  9 15 13  6  1 12  0  2 11  7  5  3) 
         (11  8 12  0  5  2 15 13 10 14  3  6  7  1  9  4) 
         ( 7  9  3  1 13 12 11 14  2  6  5 10  4  0 15  8) 
         ( 9  0  5  7  2  4 10 15 14  1 11 12  6  8  3 13) 
         ( 2 12  6 10  0 11  8  3  4 13  7  5 15 14  1  9) 
         (12  5  1 15 14 13  4 10  0  7  6  3  9  2  8 11) 
         (13 11  7 14 12  1  3  9  5  0 15  4  8  6  2 10) 
         ( 6 15 14  9 11  3  0  8 12  2 13  7  1  4 10  5) 
         (10  2  8  4  7  6  1  5 15 11  9 14  3 12 13  0) 
         ( 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15) 
         (14 10  4  8  9 15 13  6  1 12  0  2 11  7  5  3) ) ) )
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
(de _Gblake2b (A B C D X Y)
   (let
      (VA (get V A)
         VB (get V B)
         VC (get V C)
         VD (get V D) )
      (set
         'VA (add64 VA VB X)
         'VD (ror64 (x| VD VA) 32)
         'VC (add64 VC VD)
         'VB (ror64 (x| VB VC) 24)
         'VA (add64 VA VB Y)
         'VD (ror64 (x| VD VA) 16)
         'VC (add64 VC VD)
         'VB (ror64 (x| VB VC) 63) 
         (nth V A) VA
         (nth V B) VB
         (nth V C) VC
         (nth V D) VD ) ) )
(de blake2b (Lst Key Out)
   (default Out 64)
   (let
      (Len (length Lst)
         KeyLen (length Key)
         H (copy *BLAKE2B-IV)
         C 0 )
      # Lst
      (if Lst
         (setq
            Lst
            (need 
               (* -128 (/ (+ Len 127) 128))
               (copy Lst)
               0 ) )
         (or Key (setq Lst (need 128 0))) )
      # Key
      (and
         Key
         (inc 'Len 128)
         (setq Lst
            (conc
               (need
                  (* -128 (/ (+ KeyLen 127) 128))
                  (copy Key)
                  0 )
               Lst ) ) )
      (set H 
         (x| (car H) `(hex "1010000") (>> -8 KeyLen) Out) )
      (while Lst
         (let
            (M 
               (make
                  (do 16
                     (link (endian (cut 8 'Lst))) ) )
               V (conc (copy H) (copy *BLAKE2B-IV)) )
            (if (< Len 128)
               (inc 'C (swap 'Len 0))
               (inc 'C 128) 
               (dec 'Len 128) )
            (set
               (prog1 (nth V 13) (setq @@ (car @))) (x| @@ (mod64 C))
               (prog1 (nth V 14) (setq @@ (car @))) (x| @@ (>> 64 C)) )
            (and
               (=0 Len)
               (set (prog1 (nth V 15) (setq @@ (car @))) (not64 @@)) )
            (for S *BLAKE2B-S
               (let MS (mapcar '((I) (get M I)) S)
                  (_Gblake2b 1 5  9 13 (++ MS) (++ MS))
                  (_Gblake2b 2 6 10 14 (++ MS) (++ MS))
                  (_Gblake2b 3 7 11 15 (++ MS) (++ MS))
                  (_Gblake2b 4 8 12 16 (++ MS) (++ MS))
                  (_Gblake2b 1 6 11 16 (++ MS) (++ MS))
                  (_Gblake2b 2 7 12 13 (++ MS) (++ MS))
                  (_Gblake2b 3 8  9 14 (++ MS) (++ MS))
                  (_Gblake2b 4 5 10 15 (++ MS) (++ MS)) ) )
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
(de blake2b_hex (Lst Key Out)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (blake2b Lst Key Out) ) ) )

