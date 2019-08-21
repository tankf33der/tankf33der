(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )
(de mod32* (A B)
   (mod32 (* A B)) )
(de fnv1a (Lst)
   (let (H 2166136261  P 16777619)
      (for N Lst
         (setq
            H (x| H N)
            H (mod32* H P) ) )
      H ) )
