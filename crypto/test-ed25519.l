(load "ed25519.l")

(use (X0 X1 X2 PK S)
   (in "tests/sign.input"
      (until (eof)
         (msg 'line)
         (setq X0 (hexL (till ":")))
         (setq PK (publickey X0))
         (char)
         (setq X1 (hexL (till ":"))) # later
         (char)
         (setq X2 (hexL (till ":")))
         (setq S (signature X2 X0 PK))
         (char)
         (till ":")
         (till "^J" T)
         (skip)
         (or
            (checkvalid S X2 PK)
            (quit "not valid") ) ) ) )

