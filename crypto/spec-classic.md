N
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.

Those key pairs are used to derive the following shared secrets:

- __es__ = DH(ie, RS) = DH(rs, IE)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__     = "Monokex N" (ASCII, 32 bytes, zero padded)
- __H1__     = KDF(H0, RS)
- __H2__     = KDF(H1, prelude) if there is a prelude, H1 otherwise
- __H3__     = KDF(H2, IE)
- __H4__     = KDF(H3, es)
- __H5, K1__ = ENC(H4, Zero)
- __H6, T1__ = KDF(H5, ENC(K1, p1))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || ENC(K1, p1) || T1

Note that RS is shared in advance.

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder verifies msg1, and aborts if it fails.
- The protocol is complete.  The session key is H6.


K
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.

Those key pairs are used to derive the following shared secrets:

- __es__ = DH(ie, RS) = DH(rs, IE)
- __ss__ = DH(is, RS) = DH(rs, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__     = "Monokex K" (ASCII, 32 bytes, zero padded)
- __H1__     = KDF(H0, IS)
- __H2__     = KDF(H1, RS)
- __H3__     = KDF(H2, prelude) if there is a prelude, H2 otherwise
- __H4__     = KDF(H3, IE)
- __H5__     = KDF(H4, es)
- __H6__     = KDF(H5, ss)
- __H7, K1__ = ENC(H6, Zero)
- __H8, T1__ = KDF(H7, ENC(K1, p1))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || ENC(K1, p1) || T1

Note that IS and RS are shared in advance.

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder verifies msg1, and aborts if it fails.
- The protocol is complete.  The session key is H8.


X
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.

Those key pairs are used to derive the following shared secrets:

- __es__ = DH(ie, RS) = DH(rs, IE)
- __ss__ = DH(is, RS) = DH(rs, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__     = "Monokex X" (ASCII, 32 bytes, zero padded)
- __H1__     = KDF(H0, RS)
- __H2__     = KDF(H1, prelude) if there is a prelude, H1 otherwise
- __H3__     = KDF(H2, IE)
- __H4__     = KDF(H3, es)
- __H5, K1__ = ENC(H4, Zero)
- __H6, T1__ = KDF(H5, ENC(K1, IS))
- __H7__     = KDF(H6, ss)
- __H8, K2__ = ENC(H7, Zero)
- __H9, T2__ = KDF(H8, ENC(K2, p1))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || ENC(K1, IS) || T1 || ENC(K2, p1) || T2

Note that RS is shared in advance.

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder verifies msg1, and aborts if it fails.
- Responder checks Initiator's static key, and aborts if it fails.
- The protocol is complete.  The session key is H9.


NN
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(ie, IE)__ Initiator's ephemeral key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__     = "Monokex NN" (ASCII, 32 bytes, zero padded)
- __H1__     = KDF(H0, prelude) if there is a prelude, H0 otherwise
- __H2__     = KDF(H1, IE)
- __H3__     = KDF(H2, p1)
- __H4__     = KDF(H3, RE)
- __H5__     = KDF(H4, ee)
- __H6, K1__ = ENC(H5, Zero)
- __H7, T1__ = KDF(H6, ENC(K1, p2))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, p2) || T1

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session key is H7.


NK
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __es__ = DH(ie, RS) = DH(rs, IE)
- __ee__ = DH(ie, RE) = DH(re, IE)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex NK" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0, RS)
- __H2__      = KDF(H1, prelude) if there is a prelude, H1 otherwise
- __H3__      = KDF(H2, IE)
- __H4__      = KDF(H3, es)
- __H5, K1__  = ENC(H4, Zero)
- __H6, T1__  = KDF(H5, ENC(K1, p1))
- __H7, T2__  = KDF(H6, RE)
- __H8__      = KDF(H7, ee)
- __H9, K2__  = ENC(H8, Zero)
- __H10, T3__ = KDF(H9, ENC(K2, p2))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || ENC(K1, p1) || T1
- __msg2__ = RE || ENC(K2, p2) || T2

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder verifies msg1, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session key is H10.


NX
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __es__ = DH(ie, RS) = DH(rs, IE)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex NX" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0, prelude) if there is a prelude, H0 otherwise
- __H2__      = KDF(H1, IE)
- __H3__      = KDF(H2, p1)
- __H4__      = KDF(H3, RE)
- __H5__      = KDF(H4, ee)
- __H6, K1__  = ENC(H5, Zero)
- __H7, T1__  = KDF(H6, ENC(K1, RS))
- __H8__      = KDF(H7, es)
- __H9, K2__  = ENC(H8, Zero)
- __H10, T2__ = KDF(H9, ENC(K2, p2))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, RS) || T1 || ENC(K2, p2) || T2

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator checks Responder's static key, and aborts if it fails.
- The protocol is complete.  The session key is H10.


KN
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__     = "Monokex KN" (ASCII, 32 bytes, zero padded)
- __H1__     = KDF(H0, IS)
- __H2__     = KDF(H1, prelude) if there is a prelude, H1 otherwise
- __H3__     = KDF(H2, IE)
- __H4__     = KDF(H3, p1)
- __H5__     = KDF(H4, RE)
- __H6__     = KDF(H5, ee)
- __H7__     = KDF(H6, se)
- __H8, K1__ = ENC(H7, Zero)
- __H9, T1__ = KDF(H8, ENC(K1, p2))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, p2) || T1

Note that IS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session key is H9.


KK
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __es__ = DH(ie, RS) = DH(rs, IE)
- __ss__ = DH(is, RS) = DH(rs, IS)
- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex KK" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , IS)
- __H2__      = KDF(H1 , RS)
- __H3__      = KDF(H2 , prelude) if there is a prelude, H2 otherwise
- __H4__      = KDF(H3 , IE)
- __H5__      = KDF(H4 , es)
- __H6__      = KDF(H5 , ss)
- __H7, K1__  = ENC(H6 , Zero)
- __H8, T1__  = KDF(H7 , ENC(K1, p1))
- __H9, T2__  = KDF(H8 , RE)
- __H10__     = KDF(H9 , ee)
- __H11__     = KDF(H10, se)
- __H12, K2__ = ENC(H11, Zero)
- __H13, T3__ = KDF(H12, ENC(K2, p2))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || ENC(K1, p1) || T1
- __msg2__ = RE || ENC(K2, p2) || T2

Note that IS and RS are shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder verifies msg1, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session key is H13.


KX
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)
- __es__ = DH(ie, RS) = DH(rs, IE)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex KX" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , IS)
- __H2__      = KDF(H1 , prelude) if there is a prelude, H1 otherwise
- __H3__      = KDF(H2 , IE)
- __H4__      = KDF(H3 , p1)
- __H5__      = KDF(H4 , RE)
- __H6__      = KDF(H5 , ee)
- __H7__      = KDF(H6 , se)
- __H8, K1__  = ENC(H7 , Zero)
- __H9, T1__  = KDF(H8 , ENC(K1, RS))
- __H10__     = KDF(H9 , es)
- __H11, K2__ = ENC(H10, Zero)
- __H12, T2__ = KDF(H11, ENC(K2, p2))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, RS) || T1 || ENC(K2, p2) || T2

Note that IS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator checks Responder's static key, and aborts if it fails.
- The protocol is complete.  The session key is H12.


XN
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex XN" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , prelude) if there is a prelude, H0 otherwise
- __H2__      = KDF(H1 , IE)
- __H3__      = KDF(H2 , p1)
- __H4__      = KDF(H3 , RE)
- __H5__      = KDF(H4 , ee)
- __H6, K1__  = ENC(H5 , Zero)
- __H7, T1__  = KDF(H6 , ENC(K1, p2))
- __H8, K2__  = ENC(H7 , Zero)
- __H9, T2__  = KDF(H8 , ENC(K2, IS))
- __H10__     = KDF(H9 , se)
- __H11, K3__ = ENC(H10, Zero)
- __H12, T3__ = KDF(H11, ENC(K3, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, p2) || T1
- __msg3__ = ENC(K2, IS) || T2 || ENC(K3, p3) || T3

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- Responder checks Initiator's static key, and aborts if it fails.
- The protocol is complete.  The session key is H12.


XK
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __es__ = DH(ie, RS) = DH(rs, IE)
- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex XK" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , RS)
- __H2__      = KDF(H1 , prelude) if there is a prelude, H1 otherwise
- __H3__      = KDF(H2 , IE)
- __H4__      = KDF(H3 , es)
- __H5, K1__  = ENC(H4 , Zero)
- __H6, T1__  = KDF(H5 , ENC(K1, p1))
- __H7, T2__  = KDF(H6 , RE)
- __H8__      = KDF(H7 , ee)
- __H9, K2__  = ENC(H8 , Zero)
- __H10, T3__ = KDF(H9 , ENC(K2, p2))
- __H11, K3__ = ENC(H10, Zero)
- __H12, T4__ = KDF(H11, ENC(K3, IS))
- __H13__     = KDF(H12, se)
- __H14, K4__ = ENC(H13, Zero)
- __H15, T5__ = KDF(H14, ENC(K4, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || ENC(K1, p1) || T1
- __msg2__ = RE || ENC(K2, p2) || T2
- __msg3__ = ENC(K3, IS) || T3 || ENC(K4, p3) || T4

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder verifies msg1, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- Responder checks Initiator's static key, and aborts if it fails.
- The protocol is complete.  The session key is H15.


XX
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __es__ = DH(ie, RS) = DH(rs, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex XX" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , prelude) if there is a prelude, H0 otherwise
- __H2__      = KDF(H1 , IE)
- __H3__      = KDF(H2 , p1)
- __H4__      = KDF(H3 , RE)
- __H5__      = KDF(H4 , ee)
- __H6, K1__  = ENC(H5 , Zero)
- __H7, T1__  = KDF(H6 , ENC(K1, RS))
- __H8__      = KDF(H7 , es)
- __H9, K2__  = ENC(H8 , Zero)
- __H10, T2__ = KDF(H9 , ENC(K2, p2))
- __H11, K3__ = ENC(H10, Zero)
- __H12, T3__ = KDF(H11, ENC(K3, IS))
- __H13__     = KDF(H12, se)
- __H14, K4__ = ENC(H13, Zero)
- __H15, T4__ = KDF(H14, ENC(K4, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, RS) || T1 || ENC(K2, p2) || T2
- __msg3__ = ENC(K3, IS) || T3 || ENC(K4, p3) || T4

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator checks Responder's static key, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- Responder checks Initiator's static key, and aborts if it fails.
- The protocol is complete.  The session key is H15.


IN
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__     = "Monokex IN" (ASCII, 32 bytes, zero padded)
- __H1__     = KDF(H0, prelude) if there is a prelude, H0 otherwise
- __H2__     = KDF(H1, IE)
- __H3__     = KDF(H2, IS)
- __H4__     = KDF(H3, p1)
- __H5__     = KDF(H4, RE)
- __H6__     = KDF(H5, ee)
- __H7__     = KDF(H6, se)
- __H8, K1__ = ENC(H7, Zero)
- __H9, T1__ = KDF(H8, ENC(K1, p2))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || ENC(K1, p2) || T1

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session key is H9.


IK
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __es__ = DH(ie, RS) = DH(rs, IE)
- __ss__ = DH(is, RS) = DH(rs, IS)
- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex IK" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , RS)
- __H2__      = KDF(H1 , prelude) if there is a prelude, H1 otherwise
- __H3__      = KDF(H2 , IE)
- __H4__      = KDF(H3 , es)
- __H5, K1__  = ENC(H4 , Zero)
- __H6, T1__  = KDF(H5 , ENC(K1, IS))
- __H7__      = KDF(H6 , ss)
- __H8, K2__  = ENC(H7 , Zero)
- __H9, T2__  = KDF(H8 , ENC(K2, p1))
- __H10, T3__ = KDF(H9 , RE)
- __H11__     = KDF(H10, ee)
- __H12__     = KDF(H11, se)
- __H13, K3__ = ENC(H12, Zero)
- __H14, T4__ = KDF(H13, ENC(K3, p2))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || ENC(K1, IS) || T1 || ENC(K2, p1) || T2
- __msg2__ = RE || ENC(K3, p2) || T3

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder verifies msg1, and aborts if it fails.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session key is H14.


IX
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)
- __es__ = DH(ie, RS) = DH(rs, IE)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex IX" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , prelude) if there is a prelude, H0 otherwise
- __H2__      = KDF(H1 , IE)
- __H3__      = KDF(H2 , IS)
- __H4__      = KDF(H3 , p1)
- __H5__      = KDF(H4 , RE)
- __H6__      = KDF(H5 , ee)
- __H7__      = KDF(H6 , se)
- __H8, K1__  = ENC(H7 , Zero)
- __H9, T1__  = KDF(H8 , ENC(K1, RS))
- __H10__     = KDF(H9 , es)
- __H11, K2__ = ENC(H10, Zero)
- __H12, T2__ = KDF(H11, ENC(K2, p2))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || ENC(K1, RS) || T1 || ENC(K2, p2) || T2

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator checks Responder's static key, and aborts if it fails.
- The protocol is complete.  The session key is H12.


NK1
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __es__ = DH(ie, RS) = DH(rs, IE)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__     = "Monokex NK1" (ASCII, 32 bytes, zero padded)
- __H1__     = KDF(H0, RS)
- __H2__     = KDF(H1, prelude) if there is a prelude, H1 otherwise
- __H3__     = KDF(H2, IE)
- __H4__     = KDF(H3, p1)
- __H5__     = KDF(H4, RE)
- __H6__     = KDF(H5, ee)
- __H7__     = KDF(H6, es)
- __H8, K1__ = ENC(H7, Zero)
- __H9, T1__ = KDF(H8, ENC(K1, p2))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, p2) || T1

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session key is H9.


NX1
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __es__ = DH(ie, RS) = DH(rs, IE)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex NX1" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , prelude) if there is a prelude, H0 otherwise
- __H2__      = KDF(H1 , IE)
- __H3__      = KDF(H2 , p1)
- __H4__      = KDF(H3 , RE)
- __H5__      = KDF(H4 , ee)
- __H6, K1__  = ENC(H5 , Zero)
- __H7, T1__  = KDF(H6 , ENC(K1, RS))
- __H8, K2__  = ENC(H7 , Zero)
- __H9, T2__  = KDF(H8 , ENC(K2, p2))
- __H10__     = KDF(H9 , es)
- __H11, K3__ = ENC(H10, Zero)
- __H12, T3__ = KDF(H11, ENC(K3, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, RS) || T1 || ENC(K2, p2) || T2
- __msg3__ = ENC(K3, p3) || T3

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator checks Responder's static key, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session key is H12.


K1N
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex K1N" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , IS)
- __H2__      = KDF(H1 , prelude) if there is a prelude, H1 otherwise
- __H3__      = KDF(H2 , IE)
- __H4__      = KDF(H3 , p1)
- __H5__      = KDF(H4 , RE)
- __H6__      = KDF(H5 , ee)
- __H7, K1__  = ENC(H6 , Zero)
- __H8, T1__  = KDF(H7 , ENC(K1, p2))
- __H9__      = KDF(H8 , se)
- __H10, K2__ = ENC(H9 , Zero)
- __H11, T2__ = KDF(H10, ENC(K2, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, p2) || T1
- __msg3__ = ENC(K2, p3) || T2

Note that IS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session key is H11.


K1K
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __es__ = DH(ie, RS) = DH(rs, IE)
- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex K1K" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , IS)
- __H2__      = KDF(H1 , RS)
- __H3__      = KDF(H2 , prelude) if there is a prelude, H2 otherwise
- __H4__      = KDF(H3 , IE)
- __H5__      = KDF(H4 , es)
- __H6, K1__  = ENC(H5 , Zero)
- __H7, T1__  = KDF(H6 , ENC(K1, p1))
- __H8, T2__  = KDF(H7 , RE)
- __H9__      = KDF(H8 , ee)
- __H10, K2__ = ENC(H9 , Zero)
- __H11, T3__ = KDF(H10, ENC(K2, p2))
- __H12__     = KDF(H11, se)
- __H13, K3__ = ENC(H12, Zero)
- __H14, T4__ = KDF(H13, ENC(K3, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || ENC(K1, p1) || T1
- __msg2__ = RE || ENC(K2, p2) || T2
- __msg3__ = ENC(K3, p3) || T3

Note that IS and RS are shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder verifies msg1, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session key is H14.


KK1
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)
- __es__ = DH(ie, RS) = DH(rs, IE)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex KK1" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , IS)
- __H2__      = KDF(H1 , RS)
- __H3__      = KDF(H2 , prelude) if there is a prelude, H2 otherwise
- __H4__      = KDF(H3 , IE)
- __H5__      = KDF(H4 , p1)
- __H6__      = KDF(H5 , RE)
- __H7__      = KDF(H6 , ee)
- __H8__      = KDF(H7 , se)
- __H9__      = KDF(H8 , es)
- __H10, K1__ = ENC(H9 , Zero)
- __H11, T1__ = KDF(H10, ENC(K1, p2))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, p2) || T1

Note that IS and RS are shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session key is H11.


K1K1
====

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __es__ = DH(ie, RS) = DH(rs, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex K1K1" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , IS)
- __H2__      = KDF(H1 , RS)
- __H3__      = KDF(H2 , prelude) if there is a prelude, H2 otherwise
- __H4__      = KDF(H3 , IE)
- __H5__      = KDF(H4 , p1)
- __H6__      = KDF(H5 , RE)
- __H7__      = KDF(H6 , ee)
- __H8__      = KDF(H7 , es)
- __H9, K1__  = ENC(H8 , Zero)
- __H10, T1__ = KDF(H9 , ENC(K1, p2))
- __H11__     = KDF(H10, se)
- __H12, K2__ = ENC(H11, Zero)
- __H13, T2__ = KDF(H12, ENC(K2, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, p2) || T1
- __msg3__ = ENC(K2, p3) || T2

Note that IS and RS are shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session key is H13.


K1X
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __es__ = DH(ie, RS) = DH(rs, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex K1X" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , IS)
- __H2__      = KDF(H1 , prelude) if there is a prelude, H1 otherwise
- __H3__      = KDF(H2 , IE)
- __H4__      = KDF(H3 , p1)
- __H5__      = KDF(H4 , RE)
- __H6__      = KDF(H5 , ee)
- __H7, K1__  = ENC(H6 , Zero)
- __H8, T1__  = KDF(H7 , ENC(K1, RS))
- __H9__      = KDF(H8 , es)
- __H10, K2__ = ENC(H9 , Zero)
- __H11, T2__ = KDF(H10, ENC(K2, p2))
- __H12__     = KDF(H11, se)
- __H13, K3__ = ENC(H12, Zero)
- __H14, T3__ = KDF(H13, ENC(K3, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, RS) || T1 || ENC(K2, p2) || T2
- __msg3__ = ENC(K3, p3) || T3

Note that IS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator checks Responder's static key, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session key is H14.


KX1
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)
- __es__ = DH(ie, RS) = DH(rs, IE)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex KX1" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , IS)
- __H2__      = KDF(H1 , prelude) if there is a prelude, H1 otherwise
- __H3__      = KDF(H2 , IE)
- __H4__      = KDF(H3 , p1)
- __H5__      = KDF(H4 , RE)
- __H6__      = KDF(H5 , ee)
- __H7__      = KDF(H6 , se)
- __H8, K1__  = ENC(H7 , Zero)
- __H9, T1__  = KDF(H8 , ENC(K1, RS))
- __H10, K2__ = ENC(H9 , Zero)
- __H11, T2__ = KDF(H10, ENC(K2, p2))
- __H12__     = KDF(H11, es)
- __H13, K3__ = ENC(H12, Zero)
- __H14, T3__ = KDF(H13, ENC(K3, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, RS) || T1 || ENC(K2, p2) || T2
- __msg3__ = ENC(K3, p3) || T3

Note that IS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator checks Responder's static key, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session key is H14.


K1X1
====

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)
- __es__ = DH(ie, RS) = DH(rs, IE)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex K1X1" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , IS)
- __H2__      = KDF(H1 , prelude) if there is a prelude, H1 otherwise
- __H3__      = KDF(H2 , IE)
- __H4__      = KDF(H3 , p1)
- __H5__      = KDF(H4 , RE)
- __H6__      = KDF(H5 , ee)
- __H7, K1__  = ENC(H6 , Zero)
- __H8, T1__  = KDF(H7 , ENC(K1, RS))
- __H9, K2__  = ENC(H8 , Zero)
- __H10, T2__ = KDF(H9 , ENC(K2, p2))
- __H11__     = KDF(H10, se)
- __H12__     = KDF(H11, es)
- __H13, K3__ = ENC(H12, Zero)
- __H14, T3__ = KDF(H13, ENC(K3, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, RS) || T1 || ENC(K2, p2) || T2
- __msg3__ = ENC(K3, p3) || T3

Note that IS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator checks Responder's static key, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session key is H14.


X1N
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex X1N" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , prelude) if there is a prelude, H0 otherwise
- __H2__      = KDF(H1 , IE)
- __H3__      = KDF(H2 , p1)
- __H4__      = KDF(H3 , RE)
- __H5__      = KDF(H4 , ee)
- __H6, K1__  = ENC(H5 , Zero)
- __H7, T1__  = KDF(H6 , ENC(K1, p2))
- __H8, K2__  = ENC(H7 , Zero)
- __H9, T2__  = KDF(H8 , ENC(K2, IS))
- __H10, K3__ = ENC(H9 , Zero)
- __H11, T3__ = KDF(H10, ENC(K3, p3))
- __H12__     = KDF(H11, se)
- __H13, K4__ = ENC(H12, Zero)
- __H14, T4__ = KDF(H13, ENC(K4, p4))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, p2) || T1
- __msg3__ = ENC(K2, IS) || T2 || ENC(K3, p3) || T3
- __msg4__ = ENC(K4, p4) || T4

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg4 to the Initiator.
- Initiator verifies msg4, and aborts if it fails.
- The protocol is complete.  The session key is H14.


X1K
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __es__ = DH(ie, RS) = DH(rs, IE)
- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex X1K" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , RS)
- __H2__      = KDF(H1 , prelude) if there is a prelude, H1 otherwise
- __H3__      = KDF(H2 , IE)
- __H4__      = KDF(H3 , es)
- __H5, K1__  = ENC(H4 , Zero)
- __H6, T1__  = KDF(H5 , ENC(K1, p1))
- __H7, T2__  = KDF(H6 , RE)
- __H8__      = KDF(H7 , ee)
- __H9, K2__  = ENC(H8 , Zero)
- __H10, T3__ = KDF(H9 , ENC(K2, p2))
- __H11, K3__ = ENC(H10, Zero)
- __H12, T4__ = KDF(H11, ENC(K3, IS))
- __H13, K4__ = ENC(H12, Zero)
- __H14, T5__ = KDF(H13, ENC(K4, p3))
- __H15__     = KDF(H14, se)
- __H16, K5__ = ENC(H15, Zero)
- __H17, T6__ = KDF(H16, ENC(K5, p4))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || ENC(K1, p1) || T1
- __msg2__ = RE || ENC(K2, p2) || T2
- __msg3__ = ENC(K3, IS) || T3 || ENC(K4, p3) || T4
- __msg4__ = ENC(K5, p4) || T5

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder verifies msg1, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg4 to the Initiator.
- Initiator verifies msg4, and aborts if it fails.
- The protocol is complete.  The session key is H17.


XK1
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __es__ = DH(ie, RS) = DH(rs, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex XK1" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , RS)
- __H2__      = KDF(H1 , prelude) if there is a prelude, H1 otherwise
- __H3__      = KDF(H2 , IE)
- __H4__      = KDF(H3 , p1)
- __H5__      = KDF(H4 , RE)
- __H6__      = KDF(H5 , ee)
- __H7__      = KDF(H6 , es)
- __H8, K1__  = ENC(H7 , Zero)
- __H9, T1__  = KDF(H8 , ENC(K1, p2))
- __H10, K2__ = ENC(H9 , Zero)
- __H11, T2__ = KDF(H10, ENC(K2, IS))
- __H12__     = KDF(H11, se)
- __H13, K3__ = ENC(H12, Zero)
- __H14, T3__ = KDF(H13, ENC(K3, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, p2) || T1
- __msg3__ = ENC(K2, IS) || T2 || ENC(K3, p3) || T3

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- Responder checks Initiator's static key, and aborts if it fails.
- The protocol is complete.  The session key is H14.


X1K1
====

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __es__ = DH(ie, RS) = DH(rs, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex X1K1" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , RS)
- __H2__      = KDF(H1 , prelude) if there is a prelude, H1 otherwise
- __H3__      = KDF(H2 , IE)
- __H4__      = KDF(H3 , p1)
- __H5__      = KDF(H4 , RE)
- __H6__      = KDF(H5 , ee)
- __H7__      = KDF(H6 , es)
- __H8, K1__  = ENC(H7 , Zero)
- __H9, T1__  = KDF(H8 , ENC(K1, p2))
- __H10, K2__ = ENC(H9 , Zero)
- __H11, T2__ = KDF(H10, ENC(K2, IS))
- __H12, K3__ = ENC(H11, Zero)
- __H13, T3__ = KDF(H12, ENC(K3, p3))
- __H14__     = KDF(H13, se)
- __H15, K4__ = ENC(H14, Zero)
- __H16, T4__ = KDF(H15, ENC(K4, p4))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, p2) || T1
- __msg3__ = ENC(K2, IS) || T2 || ENC(K3, p3) || T3
- __msg4__ = ENC(K4, p4) || T4

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg4 to the Initiator.
- Initiator verifies msg4, and aborts if it fails.
- The protocol is complete.  The session key is H16.


X1X
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __es__ = DH(ie, RS) = DH(rs, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex X1X" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , prelude) if there is a prelude, H0 otherwise
- __H2__      = KDF(H1 , IE)
- __H3__      = KDF(H2 , p1)
- __H4__      = KDF(H3 , RE)
- __H5__      = KDF(H4 , ee)
- __H6, K1__  = ENC(H5 , Zero)
- __H7, T1__  = KDF(H6 , ENC(K1, RS))
- __H8__      = KDF(H7 , es)
- __H9, K2__  = ENC(H8 , Zero)
- __H10, T2__ = KDF(H9 , ENC(K2, p2))
- __H11, K3__ = ENC(H10, Zero)
- __H12, T3__ = KDF(H11, ENC(K3, IS))
- __H13, K4__ = ENC(H12, Zero)
- __H14, T4__ = KDF(H13, ENC(K4, p3))
- __H15__     = KDF(H14, se)
- __H16, K5__ = ENC(H15, Zero)
- __H17, T5__ = KDF(H16, ENC(K5, p4))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, RS) || T1 || ENC(K2, p2) || T2
- __msg3__ = ENC(K3, IS) || T3 || ENC(K4, p3) || T4
- __msg4__ = ENC(K5, p4) || T5

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator checks Responder's static key, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg4 to the Initiator.
- Initiator verifies msg4, and aborts if it fails.
- The protocol is complete.  The session key is H17.


XX1
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __es__ = DH(ie, RS) = DH(rs, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex XX1" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , prelude) if there is a prelude, H0 otherwise
- __H2__      = KDF(H1 , IE)
- __H3__      = KDF(H2 , p1)
- __H4__      = KDF(H3 , RE)
- __H5__      = KDF(H4 , ee)
- __H6, K1__  = ENC(H5 , Zero)
- __H7, T1__  = KDF(H6 , ENC(K1, RS))
- __H8, K2__  = ENC(H7 , Zero)
- __H9, T2__  = KDF(H8 , ENC(K2, p2))
- __H10__     = KDF(H9 , es)
- __H11, K3__ = ENC(H10, Zero)
- __H12, T3__ = KDF(H11, ENC(K3, IS))
- __H13__     = KDF(H12, se)
- __H14, K4__ = ENC(H13, Zero)
- __H15, T4__ = KDF(H14, ENC(K4, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, RS) || T1 || ENC(K2, p2) || T2
- __msg3__ = ENC(K3, IS) || T3 || ENC(K4, p3) || T4

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator checks Responder's static key, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- Responder checks Initiator's static key, and aborts if it fails.
- The protocol is complete.  The session key is H15.


X1X1
====

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __es__ = DH(ie, RS) = DH(rs, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex X1X1" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , prelude) if there is a prelude, H0 otherwise
- __H2__      = KDF(H1 , IE)
- __H3__      = KDF(H2 , p1)
- __H4__      = KDF(H3 , RE)
- __H5__      = KDF(H4 , ee)
- __H6, K1__  = ENC(H5 , Zero)
- __H7, T1__  = KDF(H6 , ENC(K1, RS))
- __H8, K2__  = ENC(H7 , Zero)
- __H9, T2__  = KDF(H8 , ENC(K2, p2))
- __H10__     = KDF(H9 , es)
- __H11, K3__ = ENC(H10, Zero)
- __H12, T3__ = KDF(H11, ENC(K3, IS))
- __H13, K4__ = ENC(H12, Zero)
- __H14, T4__ = KDF(H13, ENC(K4, p3))
- __H15__     = KDF(H14, se)
- __H16, K5__ = ENC(H15, Zero)
- __H17, T5__ = KDF(H16, ENC(K5, p4))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || p1
- __msg2__ = RE || ENC(K1, RS) || T1 || ENC(K2, p2) || T2
- __msg3__ = ENC(K3, IS) || T3 || ENC(K4, p3) || T4
- __msg4__ = ENC(K5, p4) || T5

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator checks Responder's static key, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg4 to the Initiator.
- Initiator verifies msg4, and aborts if it fails.
- The protocol is complete.  The session key is H17.


I1N
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex I1N" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , prelude) if there is a prelude, H0 otherwise
- __H2__      = KDF(H1 , IE)
- __H3__      = KDF(H2 , IS)
- __H4__      = KDF(H3 , p1)
- __H5__      = KDF(H4 , RE)
- __H6__      = KDF(H5 , ee)
- __H7, K1__  = ENC(H6 , Zero)
- __H8, T1__  = KDF(H7 , ENC(K1, p2))
- __H9__      = KDF(H8 , se)
- __H10, K2__ = ENC(H9 , Zero)
- __H11, T2__ = KDF(H10, ENC(K2, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || ENC(K1, p2) || T1
- __msg3__ = ENC(K2, p3) || T2

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session key is H11.


I1K
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __es__ = DH(ie, RS) = DH(rs, IE)
- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex I1K" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , RS)
- __H2__      = KDF(H1 , prelude) if there is a prelude, H1 otherwise
- __H3__      = KDF(H2 , IE)
- __H4__      = KDF(H3 , es)
- __H5, K1__  = ENC(H4 , Zero)
- __H6, T1__  = KDF(H5 , ENC(K1, IS))
- __H7, K2__  = ENC(H6 , Zero)
- __H8, T2__  = KDF(H7 , ENC(K2, p1))
- __H9, T3__  = KDF(H8 , RE)
- __H10__     = KDF(H9 , ee)
- __H11, K3__ = ENC(H10, Zero)
- __H12, T4__ = KDF(H11, ENC(K3, p2))
- __H13__     = KDF(H12, se)
- __H14, K4__ = ENC(H13, Zero)
- __H15, T5__ = KDF(H14, ENC(K4, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || ENC(K1, IS) || T1 || ENC(K2, p1) || T2
- __msg2__ = RE || ENC(K3, p2) || T3
- __msg3__ = ENC(K4, p3) || T4

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder verifies msg1, and aborts if it fails.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session key is H15.


IK1
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)
- __es__ = DH(ie, RS) = DH(rs, IE)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex IK1" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , RS)
- __H2__      = KDF(H1 , prelude) if there is a prelude, H1 otherwise
- __H3__      = KDF(H2 , IE)
- __H4__      = KDF(H3 , IS)
- __H5__      = KDF(H4 , p1)
- __H6__      = KDF(H5 , RE)
- __H7__      = KDF(H6 , ee)
- __H8__      = KDF(H7 , se)
- __H9__      = KDF(H8 , es)
- __H10, K1__ = ENC(H9 , Zero)
- __H11, T1__ = KDF(H10, ENC(K1, p2))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || ENC(K1, p2) || T1

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session key is H11.


I1K1
====

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __es__ = DH(ie, RS) = DH(rs, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex I1K1" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , RS)
- __H2__      = KDF(H1 , prelude) if there is a prelude, H1 otherwise
- __H3__      = KDF(H2 , IE)
- __H4__      = KDF(H3 , IS)
- __H5__      = KDF(H4 , p1)
- __H6__      = KDF(H5 , RE)
- __H7__      = KDF(H6 , ee)
- __H8__      = KDF(H7 , es)
- __H9, K1__  = ENC(H8 , Zero)
- __H10, T1__ = KDF(H9 , ENC(K1, p2))
- __H11__     = KDF(H10, se)
- __H12, K2__ = ENC(H11, Zero)
- __H13, T2__ = KDF(H12, ENC(K2, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || ENC(K1, p2) || T1
- __msg3__ = ENC(K2, p3) || T2

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session key is H13.


I1X
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __es__ = DH(ie, RS) = DH(rs, IE)
- __se__ = DH(is, RE) = DH(re, IS)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex I1X" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , prelude) if there is a prelude, H0 otherwise
- __H2__      = KDF(H1 , IE)
- __H3__      = KDF(H2 , IS)
- __H4__      = KDF(H3 , p1)
- __H5__      = KDF(H4 , RE)
- __H6__      = KDF(H5 , ee)
- __H7, K1__  = ENC(H6 , Zero)
- __H8, T1__  = KDF(H7 , ENC(K1, RS))
- __H9__      = KDF(H8 , es)
- __H10, K2__ = ENC(H9 , Zero)
- __H11, T2__ = KDF(H10, ENC(K2, p2))
- __H12__     = KDF(H11, se)
- __H13, K3__ = ENC(H12, Zero)
- __H14, T3__ = KDF(H13, ENC(K3, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || ENC(K1, RS) || T1 || ENC(K2, p2) || T2
- __msg3__ = ENC(K3, p3) || T3

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator checks Responder's static key, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session key is H14.


IX1
===

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)
- __es__ = DH(ie, RS) = DH(rs, IE)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex IX1" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , prelude) if there is a prelude, H0 otherwise
- __H2__      = KDF(H1 , IE)
- __H3__      = KDF(H2 , IS)
- __H4__      = KDF(H3 , p1)
- __H5__      = KDF(H4 , RE)
- __H6__      = KDF(H5 , ee)
- __H7__      = KDF(H6 , se)
- __H8, K1__  = ENC(H7 , Zero)
- __H9, T1__  = KDF(H8 , ENC(K1, RS))
- __H10, K2__ = ENC(H9 , Zero)
- __H11, T2__ = KDF(H10, ENC(K2, p2))
- __H12__     = KDF(H11, es)
- __H13, K3__ = ENC(H12, Zero)
- __H14, T3__ = KDF(H13, ENC(K3, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || ENC(K1, RS) || T1 || ENC(K2, p2) || T2
- __msg3__ = ENC(K3, p3) || T3

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator checks Responder's static key, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session key is H14.


I1X1
====

Sender and recipient have the following DH key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ Initiator's static key.
- __(ie, IE)__ Initiator's ephemeral key.
- __(rs, RS)__ Responder's static key.
- __(re, RE)__ Responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = DH(ie, RE) = DH(re, IE)
- __se__ = DH(is, RE) = DH(re, IS)
- __es__ = DH(ie, RS) = DH(rs, IE)

Those shared secrets are hashed to derive the following keys
(zero is a string of zero bytes):

- __H0__      = "Monokex I1X1" (ASCII, 32 bytes, zero padded)
- __H1__      = KDF(H0 , prelude) if there is a prelude, H0 otherwise
- __H2__      = KDF(H1 , IE)
- __H3__      = KDF(H2 , IS)
- __H4__      = KDF(H3 , p1)
- __H5__      = KDF(H4 , RE)
- __H6__      = KDF(H5 , ee)
- __H7, K1__  = ENC(H6 , Zero)
- __H8, T1__  = KDF(H7 , ENC(K1, RS))
- __H9, K2__  = ENC(H8 , Zero)
- __H10, T2__ = KDF(H9 , ENC(K2, p2))
- __H11__     = KDF(H10, se)
- __H12__     = KDF(H11, es)
- __H13, K3__ = ENC(H12, Zero)
- __H14, T3__ = KDF(H13, ENC(K3, p3))

The messages contain the following (`||`denotes concatenation):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || ENC(K1, RS) || T1 || ENC(K2, p2) || T2
- __msg3__ = ENC(K3, p3) || T3

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- Initiator sends msg1 to the Responder.
- Responder receives msg1.
- Responder checks Initiator's static key, and aborts if it fails.
- Responder sends msg2 to the Initiator.
- Initiator verifies msg2, and aborts if it fails.
- Initiator checks Responder's static key, and aborts if it fails.
- Initiator sends msg3 to the Responder.
- Responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session key is H14.
