`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randL (A)
   (make (do A (link (rand 0 255)))) )
(de mono_argon2i (P S B I RL Mem)
   (let
      (PL (length P)
         SL (length S)
         R NIL )
      (native
         "libmonocypher.so"
         "crypto_argon2i"
         NIL
         (list 'R (cons RL 'B RL))
         RL
         Mem
         B
         I
         (cons NIL (cons PL) P)
         PL
         (cons NIL (cons SL) S)
         SL )
      R ) )
(de libargon2 (P S B I RL)
   (let
      (PL (length P)
         SL (length S)
         R NIL )
      (native
         "libargon2.so"
         "argon2i_hash_raw"
         'I
         I
         B
         1
         (cons NIL (cons PL) P)
         PL
         (cons NIL (cons SL) S)
         SL
         (list 'R (cons RL 'B RL))
         RL )
      R ) )
(let
   (S (* 777 1024)
      M (native "@" "malloc" 'N S)
      P (randL 1024) )
   (mono_argon2i P P 777 1 1024 M)
   (test T (fully =0 (struct M (cons 'B S))))
   (native "@" "free" NIL M) )
# min P 0, I 1, S 8, Res 4, Pwr 3
(setq MonoMem (native "@" "malloc" 'N (* 1024 (** 2 16))))
(for Pass (range 0 8)
   (println 'Pass Pass)
   (for Salt (range 8 16)
      (for Iter (range 1 2)
         (for Res (range 4 5)
            (for Power (range 3 9) # MonoMem
               (let (P (randL Pass)  S (randL Salt)  Pwr (** 2 Power))
                  (test
                     (mono_argon2i P S Pwr Iter Res MonoMem)
                     (libargon2 P S Pwr Iter Res) ) ) ) ) ) ) )
(for N 255
   (println 'N N)
   (let D (need 8 N)
      (for X (1 2 4 8 16 32 64 128)
         (map
            '((L)
               (set L X)
               (test
                  (mono_argon2i D D 8 2 4 MonoMem)
                  (libargon2 D D 8 2 4) )
               (set L N) )
            D ) ) ) )
(native "@" "free" NIL MonoMem)
(setq
   P (randL 8) 
   MEM (native "@" "calloc" 'N 1 (* 1024 2048)) )
(for (Pwr 8 (>= 2048 Pwr) (inc Pwr))
   (println 'Pwr Pwr)
   (test
      (mono_argon2i P P Pwr 1 Pwr MEM)
      (libargon2    P P Pwr 1 Pwr) ) )
(for N 6
   (println 'N N)
   (let
      (P (randL (** 10 N))
         S (randL (** 10 N))
         M (mono_argon2i P S 8 2 (** 10 N) MEM)
         L (libargon2  P S 8 2 (** 10 N)) )
      (println (length M))
      (test (head 128 M) (head 128 L))
      (test (tail 128 M) (tail 128 L)) ) )
(native "@" "free" NIL MEM)


(msg 'ok)
(bye)
