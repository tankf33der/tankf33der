08:38 <Regenaxer> (/ N (** 10 *Scl) gives the integer part
08:38 <Regenaxer> (rounds down)
08:39 <Regenaxer> : (/ 1234 100)
08:39 <Regenaxer> -> 12
08:40 <Regenaxer> this rounds up:
08:40 <Regenaxer> : (/ (+ 1234 99) 100)
08:40 <Regenaxer> -> 13

ceil floor rounds
