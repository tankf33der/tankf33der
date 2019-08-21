`(== 64 64)

# compile with ED25519_SHA512 
#(load "test-eddsa.l")
(load "test-x25519.l")

# apply ietf patch chacha20 unlock box
#(load "test-chacha20.l")

(msg 'All-OK)
(bye)
