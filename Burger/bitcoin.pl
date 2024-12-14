#!/usr/bin/picolisp /usr/lib/picolisp/lib.l
# 18aug22abu

(scl 8)
(load "@lib/misc.l" "@lib/json.l")

(if (format (setq *Arg (opt)))
   (setq *WalletCpt (pack "w" (abs (setq *Arg @)) ".cpt"))
   (apply call (argv) "bitcoin-cli" "-datadir=." *Arg)
   (bye) )

(when (info "bitcoind.pid")
   (prinl "bitcoind running")
   (bye) )

(sys "CCRYPT"
   (pack
      (make
         (until (sub? (setq C (key)) "^J^M")
            (if (= "^?" C)
               (made (cdr (rot (made))))
               (link C) ) ) ) ) )

(de bitcoin @
   (in (pass list "bitcoin-cli" "-datadir=.") (readJson)) )

(de addresses (Acc)
   (bitcoin "getaddressesbylabel" Acc) )

(de accounts ()
   (let L (bitcoin "listlabels")
      (cons "\"\"" (cdr L)) ) )

(de account ()
   (let? Lst (accounts)
      (let (L Lst  Str)
         (loop
            (NIL (cdr L)
               (unless (== "\"\"" (prinl (car L)))
                  (car L) ) )
            (for A L
               (prinl "   " A) )
            (prin "? " Str)
            (flush)
            (setq Str (pack Str (prinl (key))))
            (unless (setq L (filter '((S) (pre? Str S)) L))
               (setq L Lst)
               (off Str) ) ) ) ) )

(de btc (Val)
   (format Val *Scl) )

(de fmtAttr (Nm Val)
   (tab (3 -16 16)
      NIL
      Nm
      (if (num? Val)
         (btc Val)
         Val ) ) )

(when (call "mv" *WalletCpt "wallet.dat.cpt")
   (finally (call "mv" "wallet.dat.cpt" *WalletCpt)
      (when (call "ccrypt" "-d" "-ECCRYPT" "wallet.dat.cpt")
         (finally (call "ccrypt" "-e" "-ECCRYPT" "wallet.dat")
            (out "bitcoin.conf"
               (prinl "rpcuser=pilbtc")
               (prinl "rpcpassword=" (in "/dev/urandom" (rd 20))) )
            (if (gt0 *Arg)
               (and
                  (call "bitcoind" "-datadir=." "-daemon")
                  (wait 7000 (gt0 (car (info "bitcoind.pid"))))
                  (setq *Bitcoind (in "bitcoind.pid" (read)))
                  (finally
                     (when (info "bitcoind.pid")
                        (call "bitcoin-cli" "-datadir=." "stop")
                        (loop
                           (wait 1000)
                           (NIL (info "bitcoind.pid")) ) )
                     (setq *Start (usec))
                     (loop
                        (prinl)
                        (prinl "[Q]uit [I]nfo [B]alance [R]eceived [T]ransactions [A]ddresses [V]alidate [S]end")
                        (prin
                           *Arg
                           " ["
                           (tim$ (/ (- (usec) *Start) 1000000))
                           "] " )
                        (T (= "Q" (println (setq C (uppc (key))))))
                        (case C
                           (("^J" "^M")
                              (call "ps" "-H" "-o" "pid,start,size,pcpu" "-C" 'bitcoind) )
                           ("I"
                              (for X (bitcoin "getwalletinfo")
                                 (space 3)
                                 (println X) ) )
                           ("B"
                              (mapc prinl (accounts))
                              (prinl "==========")
                              (prinl
                                 (btc
                                    (in '("bitcoin-cli" "-datadir=." "getbalance")
                                       (read) ) ) ) )
                           ("R"
                              (for X (bitcoin "listreceivedbyaddress")
                                 (tab (3 -16 -36 16 12)
                                    NIL
                                    (cdr (assoc "account" X))
                                    (cdr (assoc "address" X))
                                    (btc (cdr (assoc "amount" X)))
                                    (cdr (assoc "confirmations" X)) ) ) )
                           ("T"
                              (for X (bitcoin "listtransactions" "*" 60)
                                 (tab (3 -9 8 16 16 7 20)
                                    NIL
                                    (cdr (assoc "category" X))
                                    (datSym
                                       (/
                                          (+ (cdr (assoc "time" X)) (* 86400 (date 1970 1 1)))
                                          86400 ) )
                                    (btc (cdr (assoc "amount" X)))
                                    (btc (cdr (assoc "fee" X)))
                                    (cdr (assoc "confirmations" X))
                                    (cdr (assoc "comment" X)) ) ) )
                           ("A"
                              (for A (addresses (account))
                                 (apply println A) ) )
                           ("V"
                              (out NIL (prin "Address: "))
                              (and
                                 (setq *Valid (in NIL (line T)))
                                 (n== 'true
                                    (println (cdr (assoc "isvalid" (bitcoin "validateaddress" *Valid)))) )
                                 (off *Valid) ) )
                           ("S"
                              (when *Valid
                                 (out NIL (prin @ " : "))
                                 (let? S (in NIL (line T))
                                    (for X (bitcoin "sendtoaddress" *Valid S)
                                       (space 3)
                                       (println X) ) ) ) )
                           (T (beep)) ) ) ) )
               (prin "Hit any key .. ")
               (key)
               ## bitcoind -datadir=. -upgradewallet
               ## bitcoind -datadir=. -reindex
               ## btc stop
               (prinl) ) ) ) ) )

(bye)
