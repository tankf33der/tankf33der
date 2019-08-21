`(== 64 64)

(setq Hints (native "@" "calloc" 'N 1 48))
(struct Hints 'I -1 (0 . 4) -1)
#{
   PF_UNSPEC  0
   PF_INET    2
   PF_INET6  10
}#

(native 
   "@" 
   "getaddrinfo" 
   NIL # checkme
   (car (argv)) 
   NIL 
   Hints 
   '(R (8 . N) . 0) )
(use (A P S)
   (loop
      (setq @@
         (struct 
            R 
            '(I I I I I I N N N) ) )
      (setq A 
         (+ 
            (get @@ 7) # struct sockaddr *ai_addr
            (if (= 2 (setq P (get @@ 2))) 
               4 
               8 ) ) )
      (native 
         "@" 
         "inet_ntop" 
         NIL 
         P 
         A 
         '(S (46 C . 46)) 
         46 )
      (println 'Addr-> (pack S))
      (T (=0 (last @@)))
      (setq R (last @@)) ) )
(bye)
