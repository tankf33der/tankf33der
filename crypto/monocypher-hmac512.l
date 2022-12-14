`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(load "sha512.l")
(load "hmac.l")
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de h2l (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de l2hex (Lst)
   (lowc
      (pack
         (mapcar '((B) (pad 2 (hex B))) Lst) ) ) )
(de s2l (Str)
   (mapcar char (chop Str)) )
(de mono-hmac (M K)
   (let (ML (length M)  KL (length K)  R)
      (native
         "libmonocypher.so"
         "crypto_hmac_sha512"
         NIL
         '(R (64 B . 64))
         (if K (cons NIL (cons KL) K) 0)
         KL
         (if M (cons NIL (cons ML) M) 0)
         ML )
      R ) )
# RFC 7 vectors
(test
   (h2l "87aa7cdea5ef619d4ff0b4241a1d6cb02379f4e2ce4ec2787ad0b30545e17cdedaa833b7d6b8a702038b274eaea3f4e4be9d914eeb61f1702e696c203a126854")
   (mono-hmac (s2l "Hi There") (need 20 11)) )
(test
   (h2l "164b7a7bfcf819e2e395fbe73b56e0a387bd64222e831fd610270cd7ea2505549758bf75c05a994a6d034f65f8f0e6fdcaeab1a34d4a6b4b636e070a38bce737")
   (mono-hmac (s2l "what do ya want for nothing?") (s2l "Jefe")) )
(test
   (h2l "fa73b0089d56a284efb0f0756c890be9b1b5dbdd8ee81a3655f83e33b2279d39bf3e848279a722c806b485a47e67c807b946a337bee8942674278859e13292fb")
   (mono-hmac (need 50 221) (need 20 170)) )
(test
   (h2l "b0ba465637458c6990e5a8c5f61d4af7e576d97ff94b872de76f8050361ee3dba91ca5c11aa25eb4d679275cc5788063a5f19741120c4f2de2adebeb10a298dd")
   (mono-hmac (need 50 205) (range 1 25)) )
(test
   (h2l "80b24263c7c1a3ebb71493c1dd7be8b49b46d1f41b4aeec1121b013783f8f3526b56d037e05f2598bd0fd2215d6a1e5295e64f73f63f0aec8b915a985d786598")
   (mono-hmac (s2l "Test Using Larger Than Block-Size Key - Hash Key First") (need 131 170)) )
(test
   (h2l "e37b6a775dc87dbaa4dfa9f96e5e3ffddebd71f8867289865df5a32d20cdc944b6022cac3c4982b10d5eeb55c3e4de15134676fb6de0446065c97440fa8c6a58")
   (mono-hmac (s2l "This is a test using a larger than block-size key and a larger than block-size data. The key needs to be hashed before being used by the HMAC algorithm.") (need 131 170)) )
# golang
(test
   (h2l "9cb8abb703b31746d63477d88e6b9b2ef428b5ab5ad5a1c6db91c6ffc2c4f3e89f154eecc4efe9a8b66b08183d0e79afc581b9cd2223377dba7323bda0dfab35")
   (mono-hmac (s2l "Today web engineering has modern apps adhere to what is known as a single-page app (SPA) model.") (s2l "4234kxzjcjj3nxnxbcvsjfjzaqwsxcderfvbgtyhnmjuik4234kxzjcjj3nxnxbcvsjfjzaqwsxcderfvbgtyhnmjuik")) )
(use (Klen Tlen Key Msg Mac C)
   (zero C)
   (in "tests/hmac-sha512.txt"
      (while (from "Klen = ")
         (inc 'C)
         (setq Klen (read))
         (from "Tlen = ")
         (setq Tlen (read))
         (from "Key = ")
         (setq Key (h2l (line T)))
         (from "Msg = ")
         (setq Msg (h2l (line T)))
         (from "Mac = ")
         (setq Mac (h2l (line T)))
         (test
            Mac
            (head Tlen (mono-hmac Msg Key)) ) ) ) )
# against picolisp
(for N 1024
   (let D (randL N)
      (test
         (mono-hmac NIL D)
         (hmac 'sha512 NIL D 128) ) ) )
(msg 'ok)
(bye)
