(load "crypto/aes-sbox.l")

(setq 
   A (21 33 44 51)
   B (44 65 76 99)
   C (32 45 66 91)
   D (11 23 43 54) )
(setq Key '(A B C D))

(de colmn-get (Lst N)
   (mapcar
      '((L)
         (get (val L) N) )
      Lst ) )

(de colmn-set (Lst Num L)
   (mapc
      '(("Lst" "A")
         (set (nth (val "Lst") Num) "A") )
      Lst L ) )

(de matrx-prn-old (Lst)
   (for L Lst
      (println (val L)) ) )

(de subbytes (Lst)
   (map
      '((L)
         (set L (get *S (inc (car L)))) )
      Lst ) )

(de x|3 (A B C)
   (if C
      (x| A B C)
      (x| A B) ) )

(setq L1 (colmn-get Key 1))
(do 3 (rot L1))
(test (44 32 11 21) L1) 

(subbytes L1)
(test (113 183 43 89) L1)

(test 
   (21 44 32 11)
   (colmn-get Key 1) )

(colmn-set Key 4 (7 7 7 88))
(test
   (7 7 7 88)
   (colmn-get Key 4) )

(colmn-set
   Key
   3 
   (mapcar
      x|
      (colmn-get Key 2)
      (colmn-get Key 4) ) )
(test
   (38 70 42 79)
   (colmn-get Key 3) )

# AES
(setq CK (43 126 21 22 40 174 210 166 171 247 21 136 9 207 79 60))
(off A B C D L1)
(for (L CK L)
   (push 'A (pop 'L))
   (push 'B (pop 'L))
   (push 'C (pop 'L))
   (push 'D (pop 'L)) )
#(matrx-prn Key)
#(prinl)

(setq L1
   (colmn-get Key 1) )
(do 3 (rot L1))
(subbytes L1)
(colmn-set
   Key
   4
   (mapcar
      x|3
      L1
      (colmn-get Key 4)
      (cons 1) # XXX
   ) )

(for I (3 2 1)
   (colmn-set
      Key
      I
      (mapcar
         x|
         (colmn-get Key I)
         (colmn-get Key (inc I)) ) ) )
(test (42 108 118 5) (colmn-get Key 1))

# 2
(setq L1
   (colmn-get Key 1) )
(do 3 (rot L1))
(subbytes L1)
(colmn-set
   Key
   4
   (mapcar
      x|3
      L1
      (colmn-get Key 4)
      (cons 2) # XXX
   ) )

(for I (3 2 1)
   (colmn-set
      Key
      I
      (mapcar
         x|
         (colmn-get Key I)
         (colmn-get Key (inc I)) ) ) )
(test (242 194 149 242) (colmn-get Key 4))

# AES reimplementation
(undef 'colmn-set)
(de colmn-set (S D)
   (map
      '((S D)
         (set D (x| (car S) (car D))) )
      S D ) )

(de list-hex (L)
   (mapc
      '((N) (println (intern (pad 2 (hex N)))))
      L ) )

(de matrx-prn (KA KB KC KD)
   (mapc
      '((A B C D)
         (printsp
            (intern (pad 2 (hex A)))
            (intern (pad 2 (hex B)))
            (intern (pad 2 (hex C)))
            (intern (pad 2 (hex D))) )
         (prinl) )
      KA KB KC KD ) )

(setq CK (43 126 21 22 40 174 210 166 171 247 21 136 9 207 79 60))
(off KA KB KC KD)
(setq KA (cut 4 'CK))
(setq KB (cut 4 'CK))
(setq KC (cut 4 'CK))
(setq KD (cut 4 'CK))
(setq L1 NIL)

(matrx-prn KA KB KC KD)

(setq L1 (copy KD))
(do 3
   (rot L1) )
(subbytes L1)
(list-hex KD)
(prinl)
(list-hex L1)
(prinl)
(colmn-set L1 KA)
(list-hex KA)
(set KA (x| (car KA) 1))
(list-hex KA)

(list-hex KD)


(colmn-set KA KB)
(colmn-set KB KC)
(colmn-set KC KD)
(matrx-prn KA KB KC KD)


#shift
(de row-get (N)
   (mapcar
      '((L)
         (get (val L) N) )
      '(KA KB KC KD) ) )
(de row-set (L N)
   (mapc
      '((S D)
         (set (nth (val D) N) S) )
      L
      '(KA KB KC KD) ) )

(prinl) (prinl)
(setq II (212 39 17 174 224 191 152 241 184 180 93 229 30 65 82 48))
(off KA KB KC KD)

(setq KA (cut 4 'II))
(setq KB (cut 4 'II))
(setq KC (cut 4 'II))
(setq KD (cut 4 'II))
(matrx-prn KA KB KC KD)

(mapc
   '((Lst)
      (let L (row-get (car Lst)) # XXX
         (do (cdr Lst)
            (rot L) )
         (row-set L (car Lst)) ) )
   '((2 . 3) (3 . 2) (4 . 1)) )
(prinl)
(matrx-prn KA KB KC KD)

(msg 'OK)
(bye)

