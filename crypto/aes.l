# http://www.springer.com/us/book/9783540425809
# http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf
# The Design of Rijndael 

#{
Pure brutality and limits:
o) AES128 only
o) no decryption (boring after all this)
o) less GC mess
o) no ECB-CBC modes
o) valid input key length only 128 bits
}#

(load "aes-sbox.l")

(setq *Rcon (circ 1 2 4 8 16 32 64 128 27 54 108))

(de xtime (X)
   (if (=0 (& X `(hex "80")))
      (>> -1 X)
      (& (x| (>> -1 X) `(hex "1B")) `(hex "FF"))) )

(de setbytes (Lst)
   (map
      '((L)
         (set L (get *AES-S (inc (car L)))) )
      Lst ) )

(de colmn-xor (S D)
   (map
      '(("Src" "Dest")
         (set "Dest" (x| (car "Src") (car "Dest"))) )
      S D ) )

(de row-get (N)
   (mapcar
      '((L) (get (val L) N))
      '(A B C D) ) )

(de row-set (L N)
   (mapc
      '(("Src" "Dest") (set (nth (val "Dest") N) "Src"))
      L
      '(A B C D) ) )

(de addRoundKey (A B C D KA KB KC KD)
   (let L1 (copy KD)
      (colmn-xor KA A)
      (colmn-xor KB B)
      (colmn-xor KC C)
      (colmn-xor KD D)

      (do 3
         (rot L1) )
      (setbytes L1)
      (colmn-xor L1 KA)
      (set KA (x| (car KA) (pop '*Rcon)))
      (colmn-xor KA KB)
      (colmn-xor KB KC)
      (colmn-xor KC KD) ) )

(de shiftRows ()
   (mapc
      '((Lst)
         (let L (row-get (car Lst))
            (do (cdr Lst)
               (rot L) )
            (row-set L (car Lst)) ) )
      '((2 . 3) (3 . 2) (4 . 1)) ) )

(de mixColumns ()
   (mapc
      '(("Col")
         (let
            (X (apply x| (val "Col"))
               U (car (val "Col")) )
            (map
               '(("Dest")
                  (set "Dest"
                     (x|
                        (car "Dest")
                        X
                        (xtime (x| (car "Dest") (or (cadr "Dest") U))) ) ) )
               (val "Col") ) ) )
      '(A B C D) ) )

(de subBytes (A B C D)
   (setbytes A)
   (setbytes B)
   (setbytes C)
   (setbytes D) )

# small warm kitty
(de aes (P K)
   ~(assert (= 16 (length P) (length K)))
   (let
      (A (cut 4 'P)
         B (cut 4 'P)
         C (cut 4 'P)
         D (cut 4 'P)
         KA (cut 4 'K)
         KB (cut 4 'K)
         KC (cut 4 'K)
         KD (cut 4 'K) )
      (addRoundKey A B C D KA KB KC KD)
      (do 9
         (subBytes A B C D)
         (shiftRows)
         (mixColumns)
         (addRoundKey A B C D KA KB KC KD) )
      (subBytes A B C D)
      (shiftRows)
      (addRoundKey A B C D KA KB KC KD) 
      (pack
         (mapcar
            '((N)
               (pad 2 (hex N)) )
            (append A B C D) ) ) ) )
