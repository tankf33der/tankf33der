(de permute (N Lst)
   (co 'next
      (let
         (Lst Lst 
            N N 
            Y (need N 1)
            Z (length Lst) )
         (yield 'ready)
         (do (** Z N)
            (yield (mapcar '((I) (get Lst I)) Y))
            (let (A Y  Flg)
               (until Flg
                  (inc A)
                  (ifn (> (car A) Z)
                     (on Flg)
                     (set A 1)
                     (++ A) ) ) ) )
         NIL ) ) )

(permute 3 (range 1 4))          # set iterator
(println (permute 'next))        # first
(do 32 (permute 'next))          # skip a few
(println (permute 'next))        # next after skip


(co 'next)                       # boring, stop it
(permute 3 (range 1 256))        # reset to new one
                                 # 16M items
(println (permute 'next))
(do (>> -21 1) (permute 'next))  # skip ~2M items
(println (permute 'next))        # next after skip

(msg 'ok)
(bye)

#{
12:26 <Regenaxer> I prefer for permutations this pattern (used in several places):
12:26 <Regenaxer>    (recur (L)  # Permute
12:26 <Regenaxer>       (if (cdr L)
12:26 <Regenaxer>          (do (length L)
12:26 <Regenaxer>             (recurse (cdr L))
12:26 <Regenaxer>             (rot L) )
12:26 <Regenaxer>       ... do something ...

Also, in rosetta: Find the missing permutation.

(de mike (Lst)
   (let L Lst
      (recur (L)
         (if (cdr L)
            (do (length L)
               (recurse (cdr L))
               (rot L) )
            (println Lst) ) ) ) )

(mike (range 1 4))

}#


