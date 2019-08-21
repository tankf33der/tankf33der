(in "crypto/tests/golang-crypto-poly1305-vectors.go"
   (until (eof)
      (let
         (M (prog1 (till ":" T) (char))
            K (prog1 (till ":" T) (char))
            Tag (line T) )
         (prinl K ":")
         (prinl M ":")
         (prinl Tag ":")
         (prinl) ) ) )
(bye)
