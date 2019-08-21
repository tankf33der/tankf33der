#13.1
(de subprop (S I P)
   (put S P (delete I (get S P))) )
(put 'ALPHA 'FOOPROP '(A B C D E))
(subprop 'ALPHA 'D 'FOOPROP)
(test
   '(A B C E)
   (get 'ALPHA 'FOOPROP) )

#13.2
(de forget-meeting (P1 P2)
   (put P1 P2 'not)
   (put P2 P1 'not) )
(forget-meeting 'Mike 'Nick)
(test
   'not
   (get 'Mike 'Nick) )

#13.3 - ignored

#13.4
(de hashprop (S P) # NIL
   (bool (get S P)) )
(put 'AA 'BB 'HI)
(test
   T
   (hashprop 'AA 'BB) )
(test
   NIL
   (hashprop 'AA 'BB1) )

#13.5-13.7 - ignored

#13.8 - 
# without rules from book, just code
(de histogram (N)
   (let R NIL
      (do N
         (accu 'R (rand 0 10) 1) )
      R ) )
#{ Output example
  0 [ 18] ******************
  1 [ 31] *******************************
  2 [ 18] ******************
  3 [ 21] *********************
  4 [ 14] **************
  5 [ 18] ******************
  6 [ 16] ****************
  7 [ 17] *****************
  8 [ 14] **************
  9 [ 14] **************
 10 [ 19] *******************
}#
(de printH (Lst)
   (for L Lst
      (prinl
         (align 3 (car L)) 
         " "
         (pack "[" (align 3 (cdr L)) "]")
         " "
         (need (cdr L) '*) ) ) )
(let H (by car sort (histogram 200))
   (test 11 (length H))
   (test 0 (caar H))
   (test T (bool (gt0 (cdar H))))
   (test 200 (sum cdr H))
   #(printH H) # comment out for output
)

#13.9 - ignored

