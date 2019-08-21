(seed (in "/dev/urandom" (rd 8)))
(load "keccak.l")
(for (I 0 (>= 1024 I) (inc I))
   (let F (tmp I)
      (out F (do I (wr (rand 0 255))))
      (test
         (in 
            (list '/root/GO/src/bin/hash 'shake-128 (tmp I)) 
            (uppc (line T)) )
         (shake128sum_hex F) ) ) )
(msg 'OK-SHAKE128SUM)
