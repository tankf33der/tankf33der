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
# (range -19 -28) for hugemem
(for N (range -8 -19)
   (println 'N N)
   (let 
      (Blks (>> N 1)
         MEM (native "@" "calloc" 'N 1 (* 1024 Blks))
         P (randL 128) )
   (test
      (prog1
         (mono_argon2i P P Blks 2 4096 MEM)
         (native "@" "free" NIL MEM) )
      (libargon2 P P Blks 2 4096) ) ) )
(msg 'ok)
(bye)
