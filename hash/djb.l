(load "hash-core.l")

(de djb (Lst)
   (let H 5381
      (for N Lst
         (setq H 
            (mod32+ N (mod32* H 33)) ) )
      H ) )

