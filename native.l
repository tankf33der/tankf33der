signed to unsigned
native
return

12:34 <Regenaxer> yes, if the number is negative, you add hex FFFFFFFF...
12:35 <Regenaxer> eg 254 in 8 bit is -2
12:36 <Regenaxer> hmm, no, you must add 100000.... :)
12:37 <Regenaxer> in case of 64 bits add `(** 2 64)
