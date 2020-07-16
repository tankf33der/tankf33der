`(== 64 64)

(setq Hints (native "@" "calloc" 'N 1 48))
(struct Hints 'I (0 . 4) (0 . 4) -1)
#{
   AF_UNSPEC   0
   SOCK_STREAM 1

	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC; // AF_INET or AF_INET6 to force version
	hints.ai_socktype = SOCK_STREAM;
}#

(native
   "@"
   "getaddrinfo"
   NIL # checkme
   (car (argv))
   0
   Hints
   '(R (8 . N)) )
(use (A P S)
   (loop
      (setq @@
         (struct
            R
            '(I I I I N N N N) ) )
      (setq A
         (+
            (get @@ 6) # struct sockaddr *ai_addr
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
