(load "crypto/sha512.l")

(de bigToL (N)
   (let R NIL
      (do 8
         (push 'R (& 255 N))
         (setq N (>> 8 N)) )
      R ) ) 
(de bigFromL (L)
   (apply 
      |
      (mapcar >> (-56 -48 -40 -32 -24 -16 -8 0) L) ) )
(de pow (Targt Ihash)
   (let (Nonce 0  TrialValue 99999999999999999999)
      (while 
         (and
            (> TrialValue Targt)
            (inc 'Nonce)
            (setq TrialValue (1pow Nonce Ihash)) ) ) 
      Nonce ) )
(de checkpow (Targt Ihash Nonce)
   (and
      (> 
         Targt
         (bigFromL (head 8 (d512 (append (bigToL Nonce) Ihash)))) )
      Nonce ) )
(de 1pow (Nonce Ihash)
   (bigFromL
      (head
         8
         (d512 (conc (bigToL Nonce) Ihash)) ) ) )
(de pow-later (Targt Ihash)
   (let (Step 64  Lim (>> -64 1))
      (for (N 1 (>= Lim N) (inc 'N Step))
         (T
            (let R
               (mapcan
                  '((A)
                     (later (cons) (cons (1pow A Ihash) A)) )
                  (range N (dec (+ N Step))) ) 
               (wait NIL (full R))
               (for L R
                  (T (> Targt (car L))
                     (cdr L) ) ) )
            @ ) ) ) )
(de pow-worker (ID Ihash)
   (co ID
      (let (Nonce (format ID)  H Ihash)
         (yield 'ready)
         (loop
            (yield (cons (1pow Nonce H) Nonce))
            (inc 'Nonce 64) ) ) ) )
(de pow-co (Targt Ihash)
   (let Steps (mapcar format (range 1 64))
      (mapc '((S) (pow-worker S Ihash)) Steps) # setup workers
      (until
         (setq @@
            (cdr
               (find
                  '((L) (> Targt (car L)))
                  (mapcar pow-worker Steps) ) ) ) )
      (mapc co Steps) # trash workers
      @@ ) )
            
