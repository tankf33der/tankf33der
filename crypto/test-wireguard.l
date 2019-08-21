`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(load "blake2s.l")

(setq W (native "@" "malloc" 'N 192))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de wireblake2s (D K O)
   (let (DL (length D) DK (length K))
      (use R
         (native
            "libwire.so"
            "blake2s"
            NIL
            (cons 'R (cons (cons O 'B O)))
            (cons NIL (cons DL) D)
            (cons NIL (cons DK) K)
            O
            DL
            DK )
         R ) ) )
(de wireinit (W O)
   (native
      "libwire.so"
      "blake2s_init"
      NIL
      W
      O ) )
(de wireinitkey (W O K)
   (let DK (length K)
      (native
         "libwire.so"
         "blake2s_init_key"
         NIL
         W
         O
         (cons NIL (cons DK) K)
         DK ) ) )
(de wireupdate (W D)
   (let DL (length D)
      (native
         "libwire.so"
         "blake2s_update"
         NIL
         W
         (cons NIL (cons DL) D)
         DL ) ) )
(de wirefin (W O)
   (let R NIL
      (native
         "libwire.so"
         "blake2s_final"
         NIL
         W
         (cons 'R (cons (cons O 'B O)))
         O )
      R ) )

(for X 256
   (let D (randL X)
      (for Y 32
         (let (K (randL Y) O (rand 1 32))
            (test (wireblake2s D K O) (blake2s D K O)) ) ) ) )
(do 256
   (let (R (rand 1 32)  K (need R (rand 1 255)))
      (wireinitkey W R K)
      (test 
         (wirefin W R)
         (blake2s NIL K R) ) ) )
(do 256
   (let
      (R (rand 1 32)
         K (need R (rand 1 255))
         A (need (rand 1 256) (rand 1 255))  
         B (copy A) )
      (wireinitkey W R K)
      (while (cut (rand 1 8) 'A)
         (wireupdate W @) )
      (test
         (wirefin W R)
         (blake2s B K R) ) ) )

(wireinit W 8)
(test
   (blake2s NIL NIL 8)
   (wirefin W 8) )
(wireinit W 32)
(test
   (blake2s NIL NIL)
   (wirefin W 32) )
(wireinitkey W 8 (mapcar char (chop "abc")))
(test
   (blake2s NIL (mapcar char (chop "abc")) 8)
   (wirefin W 8) )
(wireinitkey W 32 (mapcar char (chop "abc")))
(test
   (blake2s NIL (mapcar char (chop "abc")))
   (wirefin W 32) )
(wireinit W 32)
(wireupdate W (mapcar char (chop "abc")))
(test
   (blake2s (mapcar char (chop "abc")))
   (wirefin W 32) )
(wireinitkey W 13 (mapcar char (chop "abc")))
(wireupdate W (mapcar char (chop "abc")))
(test
   (blake2s
      (mapcar char (chop "abc"))
      (mapcar char (chop "abc"))
      13 )
   (wirefin W 13) )
#{
# Full coverage, long run
(for O 32
   (for (K 0 (>= 32 K) (inc K))
      (for (N 1 (>= 1111 N) (inc N))
         (at (0 . 500) (prin "."))
         (at (0 . 2000) (prin "!"))
         (let (K (randL K)  D1 (need N 0)  D2 (need N 255)  D3 (randL N))
            (test (wireblake2s D K O) (blake2s D K O))
            (test (wireblake2s D2 K O) (blake2s D2 K O))
            (test (wireblake2s D3 K O) (blake2s D3 K O)) )
         (flush) ) ) )
}#

(msg 'ok)
(bye)
