N
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.

Those key pairs are used to derive the following shared secrets:

- __es__ = X25519(ie, RS) = X25519(rs, IE)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__ = "Monokex N" (ASCII, 64 bytes, zero padded)
- __H1__ = Blake2b(H0 || RS)
- __H2__ = Blake2b(H1 || prelude) if there is a prelude, H1 otherwise
- __H3__ = Blake2b(H2 || IE)
- __H4__ = Blake2b(H3 || es)
- __H5__ = Blake2b(H4 || zero)
- __K1__ = Blake2b(H4 || one)
- __H6__ = Blake2b(H5 || Chacha20(K1, p1)) if msg1 has a payload, H4 otherwise
- __H7__ = Blake2b(H6 || zero)
- __T1__ = Blake2b(H6 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || Chacha20(K1, p1) || T1

Note that RS is shared in advance.

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder verifies msg1, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H7.


K
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.

Those key pairs are used to derive the following shared secrets:

- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __ss__ = X25519(is, RS) = X25519(rs, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__ = "Monokex K" (ASCII, 64 bytes, zero padded)
- __H1__ = Blake2b(H0 || IS)
- __H2__ = Blake2b(H1 || RS)
- __H3__ = Blake2b(H2 || prelude) if there is a prelude, H2 otherwise
- __H4__ = Blake2b(H3 || IE)
- __H5__ = Blake2b(H4 || es)
- __H6__ = Blake2b(H5 || ss)
- __H7__ = Blake2b(H6 || zero)
- __K1__ = Blake2b(H6 || one)
- __H8__ = Blake2b(H7 || Chacha20(K1, p1)) if msg1 has a payload, H6 otherwise
- __H9__ = Blake2b(H8 || zero)
- __T1__ = Blake2b(H8 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || Chacha20(K1, p1) || T1

Note that IS and RS are shared in advance.

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder verifies msg1, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H9.


X
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.

Those key pairs are used to derive the following shared secrets:

- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __ss__ = X25519(is, RS) = X25519(rs, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex X" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || RS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || es)
- __H5__  = Blake2b(H4  || zero)
- __K1__  = Blake2b(H4  || one)
- __H6__  = Blake2b(H5  || Chacha20(K1, IS))
- __H7__  = Blake2b(H6  || zero)
- __T1__  = Blake2b(H6  || one)
- __H8__  = Blake2b(H7  || ss)
- __H9__  = Blake2b(H8  || zero)
- __K2__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || Chacha20(K2, p1)) if msg1 has a payload, H8 otherwise
- __H11__ = Blake2b(H10 || zero)
- __T2__  = Blake2b(H10 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || Chacha20(K1, IS) || T1 || Chacha20(K2, p1) || T2

Note that RS is shared in advance.

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder verifies msg1, and aborts if it fails.
- The responder checks the initiator's static key, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H11.


NN
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(ie, IE)__ The initiator's ephemeral key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__ = "Monokex NN" (ASCII, 64 bytes, zero padded)
- __H1__ = Blake2b(H0 || prelude) if there is a prelude, H0 otherwise
- __H2__ = Blake2b(H1 || IE)
- __H3__ = Blake2b(H2 || p1) if msg1 has a payload, H2 otherwise
- __H4__ = Blake2b(H3 || RE)
- __H5__ = Blake2b(H4 || ee)
- __H6__ = Blake2b(H5 || zero)
- __K1__ = Blake2b(H5 || one)
- __H7__ = Blake2b(H6 || Chacha20(K1, p2)) if msg2 has a payload, H5 otherwise
- __H8__ = Blake2b(H7 || zero)
- __T1__ = Blake2b(H7 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, p2) || T1

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H8.


NK
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __ee__ = X25519(ie, RE) = X25519(re, IE)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex NK" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || RS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || es)
- __H5__  = Blake2b(H4  || zero)
- __K1__  = Blake2b(H4  || one)
- __H6__  = Blake2b(H5  || Chacha20(K1, p1)) if msg1 has a payload, H4 otherwise
- __H7__  = Blake2b(H6  || zero)
- __T1__  = Blake2b(H6  || one)
- __H8__  = Blake2b(H7  || zero)
- __K2__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || RE)
- __H10__ = Blake2b(H9  || zero)
- __T2__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || ee)
- __H12__ = Blake2b(H11 || zero)
- __K3__  = Blake2b(H11 || one)
- __H13__ = Blake2b(H12 || Chacha20(K3, p2)) if msg2 has a payload, H11 otherwise
- __H14__ = Blake2b(H13 || zero)
- __T3__  = Blake2b(H13 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || Chacha20(K1, p1) || T1
- __msg2__ = RE || T2 || Chacha20(K3, p2) || T3

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder verifies msg1, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H14.


NX
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __es__ = X25519(ie, RS) = X25519(rs, IE)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex NX" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || prelude) if there is a prelude, H0 otherwise
- __H2__  = Blake2b(H1  || IE)
- __H3__  = Blake2b(H2  || p1) if msg1 has a payload, H2 otherwise
- __H4__  = Blake2b(H3  || RE)
- __H5__  = Blake2b(H4  || ee)
- __H6__  = Blake2b(H5  || zero)
- __K1__  = Blake2b(H5  || one)
- __H7__  = Blake2b(H6  || Chacha20(K1, RS))
- __H8__  = Blake2b(H7  || zero)
- __T1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || es)
- __H10__ = Blake2b(H9  || zero)
- __K2__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || Chacha20(K2, p2)) if msg2 has a payload, H9 otherwise
- __H12__ = Blake2b(H11 || zero)
- __T2__  = Blake2b(H11 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, RS) || T1 || Chacha20(K2, p2) || T2

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator checks the responder's static key, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H12.


KN
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex KN" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0 || IS)
- __H2__  = Blake2b(H1 || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2 || IE)
- __H4__  = Blake2b(H3 || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4 || RE)
- __H6__  = Blake2b(H5 || ee)
- __H7__  = Blake2b(H6 || se)
- __H8__  = Blake2b(H7 || zero)
- __K1__  = Blake2b(H7 || one)
- __H9__  = Blake2b(H8 || Chacha20(K1, p2)) if msg2 has a payload, H7 otherwise
- __H10__ = Blake2b(H9 || zero)
- __T1__  = Blake2b(H9 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, p2) || T1

Note that IS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H10.


KK
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __ss__ = X25519(is, RS) = X25519(rs, IS)
- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex KK" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || IS)
- __H2__  = Blake2b(H1  || RS)
- __H3__  = Blake2b(H2  || prelude) if there is a prelude, H2 otherwise
- __H4__  = Blake2b(H3  || IE)
- __H5__  = Blake2b(H4  || es)
- __H6__  = Blake2b(H5  || ss)
- __H7__  = Blake2b(H6  || zero)
- __K1__  = Blake2b(H6  || one)
- __H8__  = Blake2b(H7  || Chacha20(K1, p1)) if msg1 has a payload, H6 otherwise
- __H9__  = Blake2b(H8  || zero)
- __T1__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || zero)
- __K2__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || RE)
- __H12__ = Blake2b(H11 || zero)
- __T2__  = Blake2b(H11 || one)
- __H13__ = Blake2b(H12 || ee)
- __H14__ = Blake2b(H13 || se)
- __H15__ = Blake2b(H14 || zero)
- __K3__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || Chacha20(K3, p2)) if msg2 has a payload, H14 otherwise
- __H17__ = Blake2b(H16 || zero)
- __T3__  = Blake2b(H16 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || Chacha20(K1, p1) || T1
- __msg2__ = RE || T2 || Chacha20(K3, p2) || T3

Note that IS and RS are shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder verifies msg1, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H17.


KX
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)
- __es__ = X25519(ie, RS) = X25519(rs, IE)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex KX" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || IS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4  || RE)
- __H6__  = Blake2b(H5  || ee)
- __H7__  = Blake2b(H6  || se)
- __H8__  = Blake2b(H7  || zero)
- __K1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || Chacha20(K1, RS))
- __H10__ = Blake2b(H9  || zero)
- __T1__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || es)
- __H12__ = Blake2b(H11 || zero)
- __K2__  = Blake2b(H11 || one)
- __H13__ = Blake2b(H12 || Chacha20(K2, p2)) if msg2 has a payload, H11 otherwise
- __H14__ = Blake2b(H13 || zero)
- __T2__  = Blake2b(H13 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, RS) || T1 || Chacha20(K2, p2) || T2

Note that IS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator checks the responder's static key, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H14.


XN
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex XN" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || prelude) if there is a prelude, H0 otherwise
- __H2__  = Blake2b(H1  || IE)
- __H3__  = Blake2b(H2  || p1) if msg1 has a payload, H2 otherwise
- __H4__  = Blake2b(H3  || RE)
- __H5__  = Blake2b(H4  || ee)
- __H6__  = Blake2b(H5  || zero)
- __K1__  = Blake2b(H5  || one)
- __H7__  = Blake2b(H6  || Chacha20(K1, p2)) if msg2 has a payload, H5 otherwise
- __H8__  = Blake2b(H7  || zero)
- __T1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || zero)
- __K2__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || Chacha20(K2, IS))
- __H11__ = Blake2b(H10 || zero)
- __T2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || se)
- __H13__ = Blake2b(H12 || zero)
- __K3__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || Chacha20(K3, p3)) if msg3 has a payload, H12 otherwise
- __H15__ = Blake2b(H14 || zero)
- __T3__  = Blake2b(H14 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, p2) || T1
- __msg3__ = Chacha20(K2, IS) || T2 || Chacha20(K3, p3) || T3

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The responder checks the initiator's static key, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H15.


XK
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex XK" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || RS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || es)
- __H5__  = Blake2b(H4  || zero)
- __K1__  = Blake2b(H4  || one)
- __H6__  = Blake2b(H5  || Chacha20(K1, p1)) if msg1 has a payload, H4 otherwise
- __H7__  = Blake2b(H6  || zero)
- __T1__  = Blake2b(H6  || one)
- __H8__  = Blake2b(H7  || zero)
- __K2__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || RE)
- __H10__ = Blake2b(H9  || zero)
- __T2__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || ee)
- __H12__ = Blake2b(H11 || zero)
- __K3__  = Blake2b(H11 || one)
- __H13__ = Blake2b(H12 || Chacha20(K3, p2)) if msg2 has a payload, H11 otherwise
- __H14__ = Blake2b(H13 || zero)
- __T3__  = Blake2b(H13 || one)
- __H15__ = Blake2b(H14 || zero)
- __K4__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || Chacha20(K4, IS))
- __H17__ = Blake2b(H16 || zero)
- __T4__  = Blake2b(H16 || one)
- __H18__ = Blake2b(H17 || se)
- __H19__ = Blake2b(H18 || zero)
- __K5__  = Blake2b(H18 || one)
- __H20__ = Blake2b(H19 || Chacha20(K5, p3)) if msg3 has a payload, H18 otherwise
- __H21__ = Blake2b(H20 || zero)
- __T5__  = Blake2b(H20 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || Chacha20(K1, p1) || T1
- __msg2__ = RE || T2 || Chacha20(K3, p2) || T3
- __msg3__ = Chacha20(K4, IS) || T4 || Chacha20(K5, p3) || T5

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder verifies msg1, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The responder checks the initiator's static key, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H21.


XX
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex XX" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || prelude) if there is a prelude, H0 otherwise
- __H2__  = Blake2b(H1  || IE)
- __H3__  = Blake2b(H2  || p1) if msg1 has a payload, H2 otherwise
- __H4__  = Blake2b(H3  || RE)
- __H5__  = Blake2b(H4  || ee)
- __H6__  = Blake2b(H5  || zero)
- __K1__  = Blake2b(H5  || one)
- __H7__  = Blake2b(H6  || Chacha20(K1, RS))
- __H8__  = Blake2b(H7  || zero)
- __T1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || es)
- __H10__ = Blake2b(H9  || zero)
- __K2__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || Chacha20(K2, p2)) if msg2 has a payload, H9 otherwise
- __H12__ = Blake2b(H11 || zero)
- __T2__  = Blake2b(H11 || one)
- __H13__ = Blake2b(H12 || zero)
- __K3__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || Chacha20(K3, IS))
- __H15__ = Blake2b(H14 || zero)
- __T3__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || se)
- __H17__ = Blake2b(H16 || zero)
- __K4__  = Blake2b(H16 || one)
- __H18__ = Blake2b(H17 || Chacha20(K4, p3)) if msg3 has a payload, H16 otherwise
- __H19__ = Blake2b(H18 || zero)
- __T4__  = Blake2b(H18 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, RS) || T1 || Chacha20(K2, p2) || T2
- __msg3__ = Chacha20(K3, IS) || T3 || Chacha20(K4, p3) || T4

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator checks the responder's static key, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The responder checks the initiator's static key, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H19.


IN
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex IN" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0 || prelude) if there is a prelude, H0 otherwise
- __H2__  = Blake2b(H1 || IE)
- __H3__  = Blake2b(H2 || IS)
- __H4__  = Blake2b(H3 || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4 || RE)
- __H6__  = Blake2b(H5 || ee)
- __H7__  = Blake2b(H6 || se)
- __H8__  = Blake2b(H7 || zero)
- __K1__  = Blake2b(H7 || one)
- __H9__  = Blake2b(H8 || Chacha20(K1, p2)) if msg2 has a payload, H7 otherwise
- __H10__ = Blake2b(H9 || zero)
- __T1__  = Blake2b(H9 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || Chacha20(K1, p2) || T1

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H10.


IK
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __ss__ = X25519(is, RS) = X25519(rs, IS)
- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex IK" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || RS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || es)
- __H5__  = Blake2b(H4  || zero)
- __K1__  = Blake2b(H4  || one)
- __H6__  = Blake2b(H5  || Chacha20(K1, IS))
- __H7__  = Blake2b(H6  || zero)
- __T1__  = Blake2b(H6  || one)
- __H8__  = Blake2b(H7  || ss)
- __H9__  = Blake2b(H8  || zero)
- __K2__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || Chacha20(K2, p1)) if msg1 has a payload, H8 otherwise
- __H11__ = Blake2b(H10 || zero)
- __T2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || zero)
- __K3__  = Blake2b(H11 || one)
- __H13__ = Blake2b(H12 || RE)
- __H14__ = Blake2b(H13 || zero)
- __T3__  = Blake2b(H13 || one)
- __H15__ = Blake2b(H14 || ee)
- __H16__ = Blake2b(H15 || se)
- __H17__ = Blake2b(H16 || zero)
- __K4__  = Blake2b(H16 || one)
- __H18__ = Blake2b(H17 || Chacha20(K4, p2)) if msg2 has a payload, H16 otherwise
- __H19__ = Blake2b(H18 || zero)
- __T4__  = Blake2b(H18 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || Chacha20(K1, IS) || T1 || Chacha20(K2, p1) || T2
- __msg2__ = RE || T3 || Chacha20(K4, p2) || T4

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder verifies msg1, and aborts if it fails.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H19.


IX
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)
- __es__ = X25519(ie, RS) = X25519(rs, IE)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex IX" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || prelude) if there is a prelude, H0 otherwise
- __H2__  = Blake2b(H1  || IE)
- __H3__  = Blake2b(H2  || IS)
- __H4__  = Blake2b(H3  || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4  || RE)
- __H6__  = Blake2b(H5  || ee)
- __H7__  = Blake2b(H6  || se)
- __H8__  = Blake2b(H7  || zero)
- __K1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || Chacha20(K1, RS))
- __H10__ = Blake2b(H9  || zero)
- __T1__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || es)
- __H12__ = Blake2b(H11 || zero)
- __K2__  = Blake2b(H11 || one)
- __H13__ = Blake2b(H12 || Chacha20(K2, p2)) if msg2 has a payload, H11 otherwise
- __H14__ = Blake2b(H13 || zero)
- __T2__  = Blake2b(H13 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || Chacha20(K1, RS) || T1 || Chacha20(K2, p2) || T2

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator checks the responder's static key, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H14.


NK1
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __es__ = X25519(ie, RS) = X25519(rs, IE)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex NK1" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0 || RS)
- __H2__  = Blake2b(H1 || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2 || IE)
- __H4__  = Blake2b(H3 || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4 || RE)
- __H6__  = Blake2b(H5 || ee)
- __H7__  = Blake2b(H6 || es)
- __H8__  = Blake2b(H7 || zero)
- __K1__  = Blake2b(H7 || one)
- __H9__  = Blake2b(H8 || Chacha20(K1, p2)) if msg2 has a payload, H7 otherwise
- __H10__ = Blake2b(H9 || zero)
- __T1__  = Blake2b(H9 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, p2) || T1

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H10.


NX1
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __es__ = X25519(ie, RS) = X25519(rs, IE)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex NX1" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || prelude) if there is a prelude, H0 otherwise
- __H2__  = Blake2b(H1  || IE)
- __H3__  = Blake2b(H2  || p1) if msg1 has a payload, H2 otherwise
- __H4__  = Blake2b(H3  || RE)
- __H5__  = Blake2b(H4  || ee)
- __H6__  = Blake2b(H5  || zero)
- __K1__  = Blake2b(H5  || one)
- __H7__  = Blake2b(H6  || Chacha20(K1, RS))
- __H8__  = Blake2b(H7  || zero)
- __T1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || zero)
- __K2__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || Chacha20(K2, p2)) if msg2 has a payload, H8 otherwise
- __H11__ = Blake2b(H10 || zero)
- __T2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || es)
- __H13__ = Blake2b(H12 || zero)
- __K3__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || Chacha20(K3, p3)) if msg3 has a payload, H12 otherwise
- __H15__ = Blake2b(H14 || zero)
- __T3__  = Blake2b(H14 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, RS) || T1 || Chacha20(K2, p2) || T2
- __msg3__ = Chacha20(K3, p3) || T3

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator checks the responder's static key, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H15.


K1N
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex K1N" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || IS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4  || RE)
- __H6__  = Blake2b(H5  || ee)
- __H7__  = Blake2b(H6  || zero)
- __K1__  = Blake2b(H6  || one)
- __H8__  = Blake2b(H7  || Chacha20(K1, p2)) if msg2 has a payload, H6 otherwise
- __H9__  = Blake2b(H8  || zero)
- __T1__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || se)
- __H11__ = Blake2b(H10 || zero)
- __K2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || Chacha20(K2, p3)) if msg3 has a payload, H10 otherwise
- __H13__ = Blake2b(H12 || zero)
- __T2__  = Blake2b(H12 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, p2) || T1
- __msg3__ = Chacha20(K2, p3) || T2

Note that IS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H13.


K1K
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex K1K" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || IS)
- __H2__  = Blake2b(H1  || RS)
- __H3__  = Blake2b(H2  || prelude) if there is a prelude, H2 otherwise
- __H4__  = Blake2b(H3  || IE)
- __H5__  = Blake2b(H4  || es)
- __H6__  = Blake2b(H5  || zero)
- __K1__  = Blake2b(H5  || one)
- __H7__  = Blake2b(H6  || Chacha20(K1, p1)) if msg1 has a payload, H5 otherwise
- __H8__  = Blake2b(H7  || zero)
- __T1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || zero)
- __K2__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || RE)
- __H11__ = Blake2b(H10 || zero)
- __T2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || ee)
- __H13__ = Blake2b(H12 || zero)
- __K3__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || Chacha20(K3, p2)) if msg2 has a payload, H12 otherwise
- __H15__ = Blake2b(H14 || zero)
- __T3__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || se)
- __H17__ = Blake2b(H16 || zero)
- __K4__  = Blake2b(H16 || one)
- __H18__ = Blake2b(H17 || Chacha20(K4, p3)) if msg3 has a payload, H16 otherwise
- __H19__ = Blake2b(H18 || zero)
- __T4__  = Blake2b(H18 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || Chacha20(K1, p1) || T1
- __msg2__ = RE || T2 || Chacha20(K3, p2) || T3
- __msg3__ = Chacha20(K4, p3) || T4

Note that IS and RS are shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder verifies msg1, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H19.


KK1
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)
- __es__ = X25519(ie, RS) = X25519(rs, IE)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex KK1" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || IS)
- __H2__  = Blake2b(H1  || RS)
- __H3__  = Blake2b(H2  || prelude) if there is a prelude, H2 otherwise
- __H4__  = Blake2b(H3  || IE)
- __H5__  = Blake2b(H4  || p1) if msg1 has a payload, H4 otherwise
- __H6__  = Blake2b(H5  || RE)
- __H7__  = Blake2b(H6  || ee)
- __H8__  = Blake2b(H7  || se)
- __H9__  = Blake2b(H8  || es)
- __H10__ = Blake2b(H9  || zero)
- __K1__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || Chacha20(K1, p2)) if msg2 has a payload, H9 otherwise
- __H12__ = Blake2b(H11 || zero)
- __T1__  = Blake2b(H11 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, p2) || T1

Note that IS and RS are shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H12.


K1K1
====

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex K1K1" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || IS)
- __H2__  = Blake2b(H1  || RS)
- __H3__  = Blake2b(H2  || prelude) if there is a prelude, H2 otherwise
- __H4__  = Blake2b(H3  || IE)
- __H5__  = Blake2b(H4  || p1) if msg1 has a payload, H4 otherwise
- __H6__  = Blake2b(H5  || RE)
- __H7__  = Blake2b(H6  || ee)
- __H8__  = Blake2b(H7  || es)
- __H9__  = Blake2b(H8  || zero)
- __K1__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || Chacha20(K1, p2)) if msg2 has a payload, H8 otherwise
- __H11__ = Blake2b(H10 || zero)
- __T1__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || se)
- __H13__ = Blake2b(H12 || zero)
- __K2__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || Chacha20(K2, p3)) if msg3 has a payload, H12 otherwise
- __H15__ = Blake2b(H14 || zero)
- __T2__  = Blake2b(H14 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, p2) || T1
- __msg3__ = Chacha20(K2, p3) || T2

Note that IS and RS are shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H15.


K1X
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex K1X" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || IS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4  || RE)
- __H6__  = Blake2b(H5  || ee)
- __H7__  = Blake2b(H6  || zero)
- __K1__  = Blake2b(H6  || one)
- __H8__  = Blake2b(H7  || Chacha20(K1, RS))
- __H9__  = Blake2b(H8  || zero)
- __T1__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || es)
- __H11__ = Blake2b(H10 || zero)
- __K2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || Chacha20(K2, p2)) if msg2 has a payload, H10 otherwise
- __H13__ = Blake2b(H12 || zero)
- __T2__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || se)
- __H15__ = Blake2b(H14 || zero)
- __K3__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || Chacha20(K3, p3)) if msg3 has a payload, H14 otherwise
- __H17__ = Blake2b(H16 || zero)
- __T3__  = Blake2b(H16 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, RS) || T1 || Chacha20(K2, p2) || T2
- __msg3__ = Chacha20(K3, p3) || T3

Note that IS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator checks the responder's static key, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H17.


KX1
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)
- __es__ = X25519(ie, RS) = X25519(rs, IE)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex KX1" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || IS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4  || RE)
- __H6__  = Blake2b(H5  || ee)
- __H7__  = Blake2b(H6  || se)
- __H8__  = Blake2b(H7  || zero)
- __K1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || Chacha20(K1, RS))
- __H10__ = Blake2b(H9  || zero)
- __T1__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || zero)
- __K2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || Chacha20(K2, p2)) if msg2 has a payload, H10 otherwise
- __H13__ = Blake2b(H12 || zero)
- __T2__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || es)
- __H15__ = Blake2b(H14 || zero)
- __K3__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || Chacha20(K3, p3)) if msg3 has a payload, H14 otherwise
- __H17__ = Blake2b(H16 || zero)
- __T3__  = Blake2b(H16 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, RS) || T1 || Chacha20(K2, p2) || T2
- __msg3__ = Chacha20(K3, p3) || T3

Note that IS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator checks the responder's static key, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H17.


K1X1
====

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)
- __es__ = X25519(ie, RS) = X25519(rs, IE)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex K1X1" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || IS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4  || RE)
- __H6__  = Blake2b(H5  || ee)
- __H7__  = Blake2b(H6  || zero)
- __K1__  = Blake2b(H6  || one)
- __H8__  = Blake2b(H7  || Chacha20(K1, RS))
- __H9__  = Blake2b(H8  || zero)
- __T1__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || zero)
- __K2__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || Chacha20(K2, p2)) if msg2 has a payload, H9 otherwise
- __H12__ = Blake2b(H11 || zero)
- __T2__  = Blake2b(H11 || one)
- __H13__ = Blake2b(H12 || se)
- __H14__ = Blake2b(H13 || es)
- __H15__ = Blake2b(H14 || zero)
- __K3__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || Chacha20(K3, p3)) if msg3 has a payload, H14 otherwise
- __H17__ = Blake2b(H16 || zero)
- __T3__  = Blake2b(H16 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, RS) || T1 || Chacha20(K2, p2) || T2
- __msg3__ = Chacha20(K3, p3) || T3

Note that IS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator checks the responder's static key, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H17.


X1N
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex X1N" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || prelude) if there is a prelude, H0 otherwise
- __H2__  = Blake2b(H1  || IE)
- __H3__  = Blake2b(H2  || p1) if msg1 has a payload, H2 otherwise
- __H4__  = Blake2b(H3  || RE)
- __H5__  = Blake2b(H4  || ee)
- __H6__  = Blake2b(H5  || zero)
- __K1__  = Blake2b(H5  || one)
- __H7__  = Blake2b(H6  || Chacha20(K1, p2)) if msg2 has a payload, H5 otherwise
- __H8__  = Blake2b(H7  || zero)
- __T1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || zero)
- __K2__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || Chacha20(K2, IS))
- __H11__ = Blake2b(H10 || zero)
- __T2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || zero)
- __K3__  = Blake2b(H11 || one)
- __H13__ = Blake2b(H12 || Chacha20(K3, p3)) if msg3 has a payload, H11 otherwise
- __H14__ = Blake2b(H13 || zero)
- __T3__  = Blake2b(H13 || one)
- __H15__ = Blake2b(H14 || se)
- __H16__ = Blake2b(H15 || zero)
- __K4__  = Blake2b(H15 || one)
- __H17__ = Blake2b(H16 || Chacha20(K4, p4)) if msg4 has a payload, H15 otherwise
- __H18__ = Blake2b(H17 || zero)
- __T4__  = Blake2b(H17 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, p2) || T1
- __msg3__ = Chacha20(K2, IS) || T2 || Chacha20(K3, p3) || T3
- __msg4__ = Chacha20(K4, p4) || T4

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg4 to the initiator.
- The initiator verifies msg4, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H18.


X1K
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex X1K" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || RS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || es)
- __H5__  = Blake2b(H4  || zero)
- __K1__  = Blake2b(H4  || one)
- __H6__  = Blake2b(H5  || Chacha20(K1, p1)) if msg1 has a payload, H4 otherwise
- __H7__  = Blake2b(H6  || zero)
- __T1__  = Blake2b(H6  || one)
- __H8__  = Blake2b(H7  || zero)
- __K2__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || RE)
- __H10__ = Blake2b(H9  || zero)
- __T2__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || ee)
- __H12__ = Blake2b(H11 || zero)
- __K3__  = Blake2b(H11 || one)
- __H13__ = Blake2b(H12 || Chacha20(K3, p2)) if msg2 has a payload, H11 otherwise
- __H14__ = Blake2b(H13 || zero)
- __T3__  = Blake2b(H13 || one)
- __H15__ = Blake2b(H14 || zero)
- __K4__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || Chacha20(K4, IS))
- __H17__ = Blake2b(H16 || zero)
- __T4__  = Blake2b(H16 || one)
- __H18__ = Blake2b(H17 || zero)
- __K5__  = Blake2b(H17 || one)
- __H19__ = Blake2b(H18 || Chacha20(K5, p3)) if msg3 has a payload, H17 otherwise
- __H20__ = Blake2b(H19 || zero)
- __T5__  = Blake2b(H19 || one)
- __H21__ = Blake2b(H20 || se)
- __H22__ = Blake2b(H21 || zero)
- __K6__  = Blake2b(H21 || one)
- __H23__ = Blake2b(H22 || Chacha20(K6, p4)) if msg4 has a payload, H21 otherwise
- __H24__ = Blake2b(H23 || zero)
- __T6__  = Blake2b(H23 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || Chacha20(K1, p1) || T1
- __msg2__ = RE || T2 || Chacha20(K3, p2) || T3
- __msg3__ = Chacha20(K4, IS) || T4 || Chacha20(K5, p3) || T5
- __msg4__ = Chacha20(K6, p4) || T6

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder verifies msg1, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg4 to the initiator.
- The initiator verifies msg4, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H24.


XK1
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex XK1" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || RS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4  || RE)
- __H6__  = Blake2b(H5  || ee)
- __H7__  = Blake2b(H6  || es)
- __H8__  = Blake2b(H7  || zero)
- __K1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || Chacha20(K1, p2)) if msg2 has a payload, H7 otherwise
- __H10__ = Blake2b(H9  || zero)
- __T1__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || zero)
- __K2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || Chacha20(K2, IS))
- __H13__ = Blake2b(H12 || zero)
- __T2__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || se)
- __H15__ = Blake2b(H14 || zero)
- __K3__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || Chacha20(K3, p3)) if msg3 has a payload, H14 otherwise
- __H17__ = Blake2b(H16 || zero)
- __T3__  = Blake2b(H16 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, p2) || T1
- __msg3__ = Chacha20(K2, IS) || T2 || Chacha20(K3, p3) || T3

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The responder checks the initiator's static key, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H17.


X1K1
====

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex X1K1" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || RS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4  || RE)
- __H6__  = Blake2b(H5  || ee)
- __H7__  = Blake2b(H6  || es)
- __H8__  = Blake2b(H7  || zero)
- __K1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || Chacha20(K1, p2)) if msg2 has a payload, H7 otherwise
- __H10__ = Blake2b(H9  || zero)
- __T1__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || zero)
- __K2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || Chacha20(K2, IS))
- __H13__ = Blake2b(H12 || zero)
- __T2__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || zero)
- __K3__  = Blake2b(H13 || one)
- __H15__ = Blake2b(H14 || Chacha20(K3, p3)) if msg3 has a payload, H13 otherwise
- __H16__ = Blake2b(H15 || zero)
- __T3__  = Blake2b(H15 || one)
- __H17__ = Blake2b(H16 || se)
- __H18__ = Blake2b(H17 || zero)
- __K4__  = Blake2b(H17 || one)
- __H19__ = Blake2b(H18 || Chacha20(K4, p4)) if msg4 has a payload, H17 otherwise
- __H20__ = Blake2b(H19 || zero)
- __T4__  = Blake2b(H19 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, p2) || T1
- __msg3__ = Chacha20(K2, IS) || T2 || Chacha20(K3, p3) || T3
- __msg4__ = Chacha20(K4, p4) || T4

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg4 to the initiator.
- The initiator verifies msg4, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H20.


X1X
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex X1X" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || prelude) if there is a prelude, H0 otherwise
- __H2__  = Blake2b(H1  || IE)
- __H3__  = Blake2b(H2  || p1) if msg1 has a payload, H2 otherwise
- __H4__  = Blake2b(H3  || RE)
- __H5__  = Blake2b(H4  || ee)
- __H6__  = Blake2b(H5  || zero)
- __K1__  = Blake2b(H5  || one)
- __H7__  = Blake2b(H6  || Chacha20(K1, RS))
- __H8__  = Blake2b(H7  || zero)
- __T1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || es)
- __H10__ = Blake2b(H9  || zero)
- __K2__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || Chacha20(K2, p2)) if msg2 has a payload, H9 otherwise
- __H12__ = Blake2b(H11 || zero)
- __T2__  = Blake2b(H11 || one)
- __H13__ = Blake2b(H12 || zero)
- __K3__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || Chacha20(K3, IS))
- __H15__ = Blake2b(H14 || zero)
- __T3__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || zero)
- __K4__  = Blake2b(H15 || one)
- __H17__ = Blake2b(H16 || Chacha20(K4, p3)) if msg3 has a payload, H15 otherwise
- __H18__ = Blake2b(H17 || zero)
- __T4__  = Blake2b(H17 || one)
- __H19__ = Blake2b(H18 || se)
- __H20__ = Blake2b(H19 || zero)
- __K5__  = Blake2b(H19 || one)
- __H21__ = Blake2b(H20 || Chacha20(K5, p4)) if msg4 has a payload, H19 otherwise
- __H22__ = Blake2b(H21 || zero)
- __T5__  = Blake2b(H21 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, RS) || T1 || Chacha20(K2, p2) || T2
- __msg3__ = Chacha20(K3, IS) || T3 || Chacha20(K4, p3) || T4
- __msg4__ = Chacha20(K5, p4) || T5

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator checks the responder's static key, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg4 to the initiator.
- The initiator verifies msg4, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H22.


XX1
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex XX1" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || prelude) if there is a prelude, H0 otherwise
- __H2__  = Blake2b(H1  || IE)
- __H3__  = Blake2b(H2  || p1) if msg1 has a payload, H2 otherwise
- __H4__  = Blake2b(H3  || RE)
- __H5__  = Blake2b(H4  || ee)
- __H6__  = Blake2b(H5  || zero)
- __K1__  = Blake2b(H5  || one)
- __H7__  = Blake2b(H6  || Chacha20(K1, RS))
- __H8__  = Blake2b(H7  || zero)
- __T1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || zero)
- __K2__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || Chacha20(K2, p2)) if msg2 has a payload, H8 otherwise
- __H11__ = Blake2b(H10 || zero)
- __T2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || es)
- __H13__ = Blake2b(H12 || zero)
- __K3__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || Chacha20(K3, IS))
- __H15__ = Blake2b(H14 || zero)
- __T3__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || se)
- __H17__ = Blake2b(H16 || zero)
- __K4__  = Blake2b(H16 || one)
- __H18__ = Blake2b(H17 || Chacha20(K4, p3)) if msg3 has a payload, H16 otherwise
- __H19__ = Blake2b(H18 || zero)
- __T4__  = Blake2b(H18 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, RS) || T1 || Chacha20(K2, p2) || T2
- __msg3__ = Chacha20(K3, IS) || T3 || Chacha20(K4, p3) || T4

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator checks the responder's static key, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The responder checks the initiator's static key, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H19.


X1X1
====

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex X1X1" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || prelude) if there is a prelude, H0 otherwise
- __H2__  = Blake2b(H1  || IE)
- __H3__  = Blake2b(H2  || p1) if msg1 has a payload, H2 otherwise
- __H4__  = Blake2b(H3  || RE)
- __H5__  = Blake2b(H4  || ee)
- __H6__  = Blake2b(H5  || zero)
- __K1__  = Blake2b(H5  || one)
- __H7__  = Blake2b(H6  || Chacha20(K1, RS))
- __H8__  = Blake2b(H7  || zero)
- __T1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || zero)
- __K2__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || Chacha20(K2, p2)) if msg2 has a payload, H8 otherwise
- __H11__ = Blake2b(H10 || zero)
- __T2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || es)
- __H13__ = Blake2b(H12 || zero)
- __K3__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || Chacha20(K3, IS))
- __H15__ = Blake2b(H14 || zero)
- __T3__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || zero)
- __K4__  = Blake2b(H15 || one)
- __H17__ = Blake2b(H16 || Chacha20(K4, p3)) if msg3 has a payload, H15 otherwise
- __H18__ = Blake2b(H17 || zero)
- __T4__  = Blake2b(H17 || one)
- __H19__ = Blake2b(H18 || se)
- __H20__ = Blake2b(H19 || zero)
- __K5__  = Blake2b(H19 || one)
- __H21__ = Blake2b(H20 || Chacha20(K5, p4)) if msg4 has a payload, H19 otherwise
- __H22__ = Blake2b(H21 || zero)
- __T5__  = Blake2b(H21 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || p1
- __msg2__ = RE || Chacha20(K1, RS) || T1 || Chacha20(K2, p2) || T2
- __msg3__ = Chacha20(K3, IS) || T3 || Chacha20(K4, p3) || T4
- __msg4__ = Chacha20(K5, p4) || T5

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator checks the responder's static key, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg4 to the initiator.
- The initiator verifies msg4, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H22.


I1N
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex I1N" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || prelude) if there is a prelude, H0 otherwise
- __H2__  = Blake2b(H1  || IE)
- __H3__  = Blake2b(H2  || IS)
- __H4__  = Blake2b(H3  || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4  || RE)
- __H6__  = Blake2b(H5  || ee)
- __H7__  = Blake2b(H6  || zero)
- __K1__  = Blake2b(H6  || one)
- __H8__  = Blake2b(H7  || Chacha20(K1, p2)) if msg2 has a payload, H6 otherwise
- __H9__  = Blake2b(H8  || zero)
- __T1__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || se)
- __H11__ = Blake2b(H10 || zero)
- __K2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || Chacha20(K2, p3)) if msg3 has a payload, H10 otherwise
- __H13__ = Blake2b(H12 || zero)
- __T2__  = Blake2b(H12 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || Chacha20(K1, p2) || T1
- __msg3__ = Chacha20(K2, p3) || T2

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H13.


I1K
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex I1K" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || RS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || es)
- __H5__  = Blake2b(H4  || zero)
- __K1__  = Blake2b(H4  || one)
- __H6__  = Blake2b(H5  || Chacha20(K1, IS))
- __H7__  = Blake2b(H6  || zero)
- __T1__  = Blake2b(H6  || one)
- __H8__  = Blake2b(H7  || zero)
- __K2__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || Chacha20(K2, p1)) if msg1 has a payload, H7 otherwise
- __H10__ = Blake2b(H9  || zero)
- __T2__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || zero)
- __K3__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || RE)
- __H13__ = Blake2b(H12 || zero)
- __T3__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || ee)
- __H15__ = Blake2b(H14 || zero)
- __K4__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || Chacha20(K4, p2)) if msg2 has a payload, H14 otherwise
- __H17__ = Blake2b(H16 || zero)
- __T4__  = Blake2b(H16 || one)
- __H18__ = Blake2b(H17 || se)
- __H19__ = Blake2b(H18 || zero)
- __K5__  = Blake2b(H18 || one)
- __H20__ = Blake2b(H19 || Chacha20(K5, p3)) if msg3 has a payload, H18 otherwise
- __H21__ = Blake2b(H20 || zero)
- __T5__  = Blake2b(H20 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || Chacha20(K1, IS) || T1 || Chacha20(K2, p1) || T2
- __msg2__ = RE || T3 || Chacha20(K4, p2) || T4
- __msg3__ = Chacha20(K5, p3) || T5

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder verifies msg1, and aborts if it fails.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H21.


IK1
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)
- __es__ = X25519(ie, RS) = X25519(rs, IE)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex IK1" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || RS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || IS)
- __H5__  = Blake2b(H4  || p1) if msg1 has a payload, H4 otherwise
- __H6__  = Blake2b(H5  || RE)
- __H7__  = Blake2b(H6  || ee)
- __H8__  = Blake2b(H7  || se)
- __H9__  = Blake2b(H8  || es)
- __H10__ = Blake2b(H9  || zero)
- __K1__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || Chacha20(K1, p2)) if msg2 has a payload, H9 otherwise
- __H12__ = Blake2b(H11 || zero)
- __T1__  = Blake2b(H11 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || Chacha20(K1, p2) || T1

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H12.


I1K1
====

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex I1K1" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || RS)
- __H2__  = Blake2b(H1  || prelude) if there is a prelude, H1 otherwise
- __H3__  = Blake2b(H2  || IE)
- __H4__  = Blake2b(H3  || IS)
- __H5__  = Blake2b(H4  || p1) if msg1 has a payload, H4 otherwise
- __H6__  = Blake2b(H5  || RE)
- __H7__  = Blake2b(H6  || ee)
- __H8__  = Blake2b(H7  || es)
- __H9__  = Blake2b(H8  || zero)
- __K1__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || Chacha20(K1, p2)) if msg2 has a payload, H8 otherwise
- __H11__ = Blake2b(H10 || zero)
- __T1__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || se)
- __H13__ = Blake2b(H12 || zero)
- __K2__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || Chacha20(K2, p3)) if msg3 has a payload, H12 otherwise
- __H15__ = Blake2b(H14 || zero)
- __T2__  = Blake2b(H14 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || Chacha20(K1, p2) || T1
- __msg3__ = Chacha20(K2, p3) || T2

Note that RS is shared in advance.

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H15.


I1X
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __es__ = X25519(ie, RS) = X25519(rs, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex I1X" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || prelude) if there is a prelude, H0 otherwise
- __H2__  = Blake2b(H1  || IE)
- __H3__  = Blake2b(H2  || IS)
- __H4__  = Blake2b(H3  || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4  || RE)
- __H6__  = Blake2b(H5  || ee)
- __H7__  = Blake2b(H6  || zero)
- __K1__  = Blake2b(H6  || one)
- __H8__  = Blake2b(H7  || Chacha20(K1, RS))
- __H9__  = Blake2b(H8  || zero)
- __T1__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || es)
- __H11__ = Blake2b(H10 || zero)
- __K2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || Chacha20(K2, p2)) if msg2 has a payload, H10 otherwise
- __H13__ = Blake2b(H12 || zero)
- __T2__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || se)
- __H15__ = Blake2b(H14 || zero)
- __K3__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || Chacha20(K3, p3)) if msg3 has a payload, H14 otherwise
- __H17__ = Blake2b(H16 || zero)
- __T3__  = Blake2b(H16 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || Chacha20(K1, RS) || T1 || Chacha20(K2, p2) || T2
- __msg3__ = Chacha20(K3, p3) || T3

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator checks the responder's static key, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H17.


IX1
===

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)
- __es__ = X25519(ie, RS) = X25519(rs, IE)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex IX1" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || prelude) if there is a prelude, H0 otherwise
- __H2__  = Blake2b(H1  || IE)
- __H3__  = Blake2b(H2  || IS)
- __H4__  = Blake2b(H3  || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4  || RE)
- __H6__  = Blake2b(H5  || ee)
- __H7__  = Blake2b(H6  || se)
- __H8__  = Blake2b(H7  || zero)
- __K1__  = Blake2b(H7  || one)
- __H9__  = Blake2b(H8  || Chacha20(K1, RS))
- __H10__ = Blake2b(H9  || zero)
- __T1__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || zero)
- __K2__  = Blake2b(H10 || one)
- __H12__ = Blake2b(H11 || Chacha20(K2, p2)) if msg2 has a payload, H10 otherwise
- __H13__ = Blake2b(H12 || zero)
- __T2__  = Blake2b(H12 || one)
- __H14__ = Blake2b(H13 || es)
- __H15__ = Blake2b(H14 || zero)
- __K3__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || Chacha20(K3, p3)) if msg3 has a payload, H14 otherwise
- __H17__ = Blake2b(H16 || zero)
- __T3__  = Blake2b(H16 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || Chacha20(K1, RS) || T1 || Chacha20(K2, p2) || T2
- __msg3__ = Chacha20(K3, p3) || T3

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator checks the responder's static key, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H17.


I1X1
====

Sender and recipient have the following X25519 key pairs (private half
in lower case, public half in upper case):

- __(is, IS)__ The initiator's static key.
- __(ie, IE)__ The initiator's ephemeral key.
- __(rs, RS)__ The responder's static key.
- __(re, RE)__ The responder's ephemeral key.

Those key pairs are used to derive the following shared secrets:

- __ee__ = X25519(ie, RE) = X25519(re, IE)
- __se__ = X25519(is, RE) = X25519(re, IS)
- __es__ = X25519(ie, RS) = X25519(rs, IE)

Those shared secrets are hashed to derive the following keys
(`||`denotes concatenation, zero and one are one byte numbers):

- __H0__  = "Monokex I1X1" (ASCII, 64 bytes, zero padded)
- __H1__  = Blake2b(H0  || prelude) if there is a prelude, H0 otherwise
- __H2__  = Blake2b(H1  || IE)
- __H3__  = Blake2b(H2  || IS)
- __H4__  = Blake2b(H3  || p1) if msg1 has a payload, H3 otherwise
- __H5__  = Blake2b(H4  || RE)
- __H6__  = Blake2b(H5  || ee)
- __H7__  = Blake2b(H6  || zero)
- __K1__  = Blake2b(H6  || one)
- __H8__  = Blake2b(H7  || Chacha20(K1, RS))
- __H9__  = Blake2b(H8  || zero)
- __T1__  = Blake2b(H8  || one)
- __H10__ = Blake2b(H9  || zero)
- __K2__  = Blake2b(H9  || one)
- __H11__ = Blake2b(H10 || Chacha20(K2, p2)) if msg2 has a payload, H9 otherwise
- __H12__ = Blake2b(H11 || zero)
- __T2__  = Blake2b(H11 || one)
- __H13__ = Blake2b(H12 || se)
- __H14__ = Blake2b(H13 || es)
- __H15__ = Blake2b(H14 || zero)
- __K3__  = Blake2b(H14 || one)
- __H16__ = Blake2b(H15 || Chacha20(K3, p3)) if msg3 has a payload, H14 otherwise
- __H17__ = Blake2b(H16 || zero)
- __T3__  = Blake2b(H16 || one)

The messages contain the following (the payloads "p*" are optional):

- __msg1__ = IE || IS || p1
- __msg2__ = RE || Chacha20(K1, RS) || T1 || Chacha20(K2, p2) || T2
- __msg3__ = Chacha20(K3, p3) || T3

To avoid network amplification attacks: the network packet containing
msg1 should be as big as the network packet containing msg2 (and its
payload, if any). Pad msg1 with zeroes as necessary

The handshake proceeds as follows:

- The initiator sends msg1 to the responder.
- The responder receives msg1.
- The responder checks the initiator's static key, and aborts if it fails.
- The responder sends msg2 to the initiator.
- The initiator verifies msg2, and aborts if it fails.
- The initiator checks the responder's static key, and aborts if it fails.
- The initiator sends msg3 to the responder.
- The responder verifies msg3, and aborts if it fails.
- The protocol is complete.  The session keys are the two halves of H17.
