# files: 
#   version.l

(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )

(de not32 (N)
   (x| N `(hex "FFFFFFFF")) )

(de totwo (N)
   (or
      (ge0 N)
      (x| (dec (abs N)) `(hex "FFFFFFFF")) ) )

(de fromtwo (N)
   (if (> `(hex "80000000") N)
      N
      (- (x| (dec N) `(hex "FFFFFFFF"))) ) )

(de bitwise (F N1 N2)
   (fromtwo
      (F (totwo N1) (totwo N2)) ) )

(de tilde (N)
   (fromtwo 
      (x| (totwo N) `(hex "FFFFFFFF")) ) )

(de leftRotate (X C)
   (| (mod32 (>> (- C) X)) (>> (- 32 C) X)) )

(de rightRotate (X C)
   (| (mod64 (>> C X)) (mod64 (>> (- C 64) X))) )

(de modulo (X Y)
   (% (+ Y (% X Y)) Y) )

(de accud (Var Key)
   (if (assoc Key (val Var))
      (con @ (inc (cdr @)))
      (push Var (cons Key 1)) )
   Key )

(de accuL (V K N)
   (if (assoc K (val V))
      (push (cdr @) N)
      (push V (list K (list N))) ) )

(de accu147 (Var Age Name)
   (let L (assoc Age (val Var))
      (ifn L
         (push Var (list Age 1 (list Name)))
         (push (cddr L) Name)
         (inc (cdr L)) ) ) )

(de accuNum (V I)
   (let X (accu V I 1)
      (if (num? X) @ (cdr X)) ) )

(de accuR (Var Key)
   (if (rassoc Key (val Var))
      (inc @)
      (push Var (cons 1 Key)) ) )

#
#
# Clojure mimic below
#
#
(de iterate ("Fun" "X")
   (list 'job (lit (env '("Fun" "X")))
      '(prog1 "X" (setq "X" ("Fun" "X"))) ) )
(de take ("N" . "Prg")
   (make (do "N" (link (run "Prg")))) )
(test (1 4 7 10 13) (take 5 `(iterate '((N) (+ 3 N)) 1)))

# let destructuring (buildin pil64)
(de destru (A E)
   (if (atom A)
      (and A (list A E))
      (and (atom E) (off E))
      (append
         (destru (car A) (car E))
         (destru (cdr A) (cdr E)) ) ) )

(de reduce ("Fun" "Lst")
   (let "A" (car "Lst")
      (for "N" (cdr "Lst")
         (setq "A" ("Fun" "A" "N")) )
      "A" ) )

(use ->
   (undef '->)
   (de -> ("X" . "A")
      (for "Form" "A"
         (setq "X" (apply (car "Form") (cdr "Form") "X")) ) )
(test
   5
   (->
      (2 5 4 1 3 6)
      (reverse)
      (cdr)
      (sort)
      (last) ) ) )

(de ->> ("X" . "A")
   (for "Form" "A"
      (setq "X" (eval (append "Form" (cons "X")))) ) )
(test
   11
   (->>
      (2 5 4 1 3 6)
      (tail -2)
      (head 3)
      (mapcar inc)
      (apply +) ) )

(de trampoline (F N)
   (let R (F N)
      (while (fun? (setq R (eval R))))
      R ) )

(de bit-flip (N I)
   (x| N (>> (- I) 1)) )
(test 170 (bit-flip 234 6))
# Clojure end

