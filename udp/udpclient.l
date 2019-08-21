`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))

(setq 
   *PF_INET    2
   *SOCK_DGRAM 2 )

(de socket NIL
   (native 
      "@" 
      "socket" 
      'I 
      *PF_INET 
      *SOCK_DGRAM 
      17 # IPPROTO_UDP
   ) )
(de getaddrinfo (Host Port)
   (let 
      (Hints NIL
         Res NIL )
      (setq Hints (native "@" "calloc" 'N 1 48))
      (struct Hints 'I (0 . 4) -2 -2) # 0, PF_INET, SOCK_DGRAM
      (native
         "@"
         "getaddrinfo"
         NIL # checkme
         Host
         Port
         Hints
         '(Res (8 . N) . 0) )
      (native "@" "free" NIL Hints)
      (struct Res '(I I I I I I N N N)) ) )
(de server (Host Port)
   (let R (getaddrinfo Host Port)
      (make
         (link 
            (socket)
            (get R 7) # ai_addr
            (get R 5) # ai_addrlen
         ) ) ) )
(de sendto (S B)
   (let BL (length B)
      (native
         "@"
         "sendto"
         NIL # checkme
         (car S)
         (cons NIL (cons BL) B)
         BL
         0
         (cadr S)
         (caddr S) ) ) )  
(de recvfrom (S)
   (let
      (Buf NIL
         N
         (native
            "@"
            "recvfrom"
            'N
            (car S)
            '(Buf (1024 B . 1024))
            1024
            0
            0
            0 ) )
      (head N Buf) ) )

(setq *Srv 
   (server "0.0.0.0" "4567") )

(do 1024
   (let L (need (rand 1 1024) 255)
      (sendto *Srv L)
      (test L (recvfrom *Srv)) ) )

(msg 'ok)
(bye)
