# (host 'any 'flg) -> lst
(de host_ (Node Flg)
   (use Lst
      (when
         (=0
            (%@
               "getaddrinfo"
               'I
               Node
               0
               (cons
                  NIL
                  (`addrinfo)
                  (0 . 4)
                  (`AF_UNSPEC . 4)
                  (cons SOCK_DGRAM 4)
                  0 )
               '(Lst (8 . P)) ) )
         (buf Host NI_MAXHOST
            (prog1
               (let P Lst
                  (make
                     (while (gt0 P)
                        (%@ "getnameinfo" 'I
                           (struct (+ P ai_addr) 'P)
                           (struct (+ P ai_addrlen) 'I)
                           Host
                           NI_MAXHOST
                           0
                           0
                           (if Flg NI_NAMEREQD NI_NUMERICHOST) )
                        (link (struct Host 'S))
                        (setq P (struct (+ P ai_next) 'P)) ) ) )
               (%@ "freeaddrinfo" 'I Lst) ) ) ) ) )

(println (host_ "pb1n.de"))


(msg 'ok)
(bye)
