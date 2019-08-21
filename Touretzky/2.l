#2.1 - ignored
# http://software-lab.de/doc/ref.html#lst
# (TO BE OR NOT TO BE)
#{
   |
   V
+--+--+-----+
| TO  |  |  |
+-----+--+--+
         | 
         V 
      +--+--+-----+
      | BE  |  |  |
      +-----+--+--+
               |
               V
            +--+--+-----+
            | OR  |  |  |
            +-----+--+--+
                     |
                     V
                  +--+--+-----+
                  | NOT |  |  |
                  +-----+--+--+
                           |
                           V
                        +--+--+-----+
                        | TO  |  |  |
                        +-----+--+--+
                                 |
                                 V
                              +--+--+-----+
                              | BE  |  |  |
                              +-----+--+--+
                                       |
                                       V
                                      NIL 
}#

#2.2
# valid - 2, 5, 6

#2.3
#{
    |
    V 
+---+----+-----+    +-----+-----+          +-----------+-----+
| PLEASE |   --|--->|  |  |   --|--------->| VALENTINE |   --|---> NIL
+--------+-----+    +--+--+-----+          +-----------+-----+
                       |
                       V
                    +--+--+-----+
                    | BE  |  |  |
                    +-----+--+--+
                             |
                             V
                          +--+--+-----+
                          | MY  |  |  |
                          +-----+--+--+
                                   |
                                   V
                                  NIL
}#

#2.4
# ((BOWS ARROWS) (FLOWERS CHOCOLATES))

#2.5
(test 6 (length '(OPEN THE POD BAY DOORS HAL)))
(test 3 (length '((OPEN) (THE POD BAY DOORS) HAL)))
(test 4 (length '((1 2 3) (4 5 6) (7 8 9) (10 11 12))))
(test 4 (length '((ONE) FOR ALL (AND (TWO (FOR ME))))))
(test
   5
   (length
      (quote
         (Q SPADES)
         (7 HEARTS)
         (6 CLUBS)
         (5 DIAMONDS)
         (2 DIAMONDS) ) ) )
(test
   6
   (length
      (quote
         (PENNSYLVANIA (THE KEYSTONE STATE))
         (NEW-JERSEY (THE GARDEN STATE))
         (MASSACHUSETTS (THE BAY STATE))
         (FLORIDA (THE SUNSHINE STATE))
         (NEW-YORK (THE EMPIRE STATE))
         (INDIAN (THE HOOSIER STATE)) ) ) )

#2.6
#{
1.   ()          ((NIL))
2.   (())        NIL
3.   ((()))      (NIL)
4.   (() ())     (NIL (NIL))
5.   (() (()))   (NIL NIL)

1 -> 2
2 -> 3
3 -> 1
4 -> 5
5 -> 4
}#

#2.7
(def 'my-rest cdr)
(def 'first car)
(de my-second (L)
   (first (my-rest L)) )
(test
   'LOVE
   (my-second '(PENGUINS LOVE ITALIAN ICES)) )
(test
   'IF
   (my-second '(HONK IF YOU LIKE GEESE)) )

#2.8
(de my-third (L)
   (first (my-rest (my-rest L))) )
(test
   3
   (my-third (range 1 6)) )

#2.9
(def 'second cadr)
(undef 'my-third)
(de my-third (L)
   (second (my-rest L)) )
(test
   3
   (my-third (range 1 6)) )

#2.10
#{
   |
   V
+--+--+-----+
|  |  |   --|--> NIL
+--+--+-----+
   |
   V
+--+--+-----+
|  |  |   --|--> NIL
+--+--+-----+
   |
   V
+--+----+-----+
| PHONE |  |  |
+-------+--+--+
           |
           V
        +--+---+-----+
        | HOME |  |  |
        +------+--+--+
                  |
                  V
                 NIL
}#

#2.11
#{
  |
  V
+-+-+---+    +-----+-----+     +-----+-----+
| A | --|--->|  |  |   --|---->|  |  |   --|---> NIL
+---+---+    +--+--+-----+     +--+--+-----+
                |                 |
                V                 V
             +--+---+-----+    +--+--+-----+
             | TOLL |  |  |    |  |  |   --|---> NIL
             +------+--+--+    +--+--+-----+
                       |          |
                       V          V
                      NIL      +--+---+-----+
                               | CALL |  |  |
                               +------+--+--+
                                         |
                                         V
                                        NIL
}#

#2.12
(test 4 (cadddr (range 1 10)))

#2.13
#{
   start    (((FUN)) (IN THE) (SUN))
   C..AR    ((FUN))
   C.AAR    (FUN)
   CAAAR    FUN

   C..DR    ((IN THE) (SUN))
   C.ADR    (IN THE)
   CAADR    IN 
   
   C...DR   ((IN THE) (SUN))
   C..ADR   (IN THE)
   C.DADR   (THE)
   CADADR   THE

   C...DR   ((IN THE) (SUN))
   C..DDR   ((SUN))
   C.ADDR   (SUN)
   CAADDR   SUN
}#

#2.14
(let *L214 '((BLUE CUBE) (RED PYRAMID))
   (test (nth *L214 2 1 1) (caadr *L214))
   (test (nth *L214 1 1 1) (caar *L214)) )

#2.15
(de cadaddr (L)
   (car (cdaddr L)) )
#{
   start    ((A B) (C D) (E F))
   CAR      (A B)
   CDDR     ((E F))
   CADR     (C D)
   CDAR     (B)
   CADAR    B
   CDDAR    NIL
   CAAR     A
   CDADDR   (F)
   CADADDR  F
}#

#2.16
# start point:
# http://software-lab.de/doc/faq.html#segfault
# valid and perfect

#2.17
(test 'POST (car '(POST NO BILLS)))
(test '(NO BILLS) (cdr '(POST NO BILLS)))
(test '(POST NO) (car '((POST NO) BILLS)))
(test NIL (cdr '(BILLS)))
(test NIL (car 'BILLS))
(test '((NO BILLS)) (cdr '(POST (NO BILLS))))
(test NIL (cdr '((POST NO BILLS))))
(test NIL (car))

#2.18
(de 2-18-1 (A B)
   (cons A B) )
(de 2-18-2 (A B)
   (cons A (cons B)) )
(test (11 . 22) (2-18-1 11 22))
(test (11 22) (2-18-2 11 22))

#2.19
(test 
   '(FRED AND WILMA) 
   (list 'FRED 'AND 'WILMA) )
(test 
   '(FRED (AND WILMA)) 
   (list 'FRED (list 'AND 'WILMA)) )
(test
   '(FRED AND WILMA)
   (cons 'FRED '(AND WILMA)) )
(test '(NIL) (cons NIL NIL))
(test '(NIL NIL) (list NIL NIL))

#2.20
(test '(NIL) (list 'NIL))
(test '(T NIL) (list T NIL))
(test '(T) (cons T NIL))
(test '((T)) (cons '(T) NIL))
(test
   '((IN ONE EAR AND) (OUT THE OTHER))
   (list
      '(IN ONE EAR AND)
      '(OUT THE OTHER) ) )
(test
   '((IN ONE EAR AND) OUT THE OTHER)
   (cons
      '(IN ONE EAR AND)
      '(OUT THE OTHER) ) )

#2.21
(de 2-21 (A B C D)
   (list
      (list A B)
      (list C D) ) )
(test
   '((1 2) (3 4))
   (2-21 1 2 3 4) )

#2.22
(de duo-cons (A B C)
   (cons A (cons B C)) )
(test
   '(PATRICK SEYMOUR MARVIN)
   (duo-cons 'PATRICK 'SEYMOUR '(MARVIN)) )

#2.23
(de two-deeper-1 (A)
   (list (list A)) )
(de two-deeper-2 (A)
   (cons (cons A)) )
(test
   (two-deeper-1 123)
   (two-deeper-2 123) )
(test
   (two-deeper-1 '(A B))
   (two-deeper-2 '(A B)) )

#2.24
(test
   'NIGHT
   (caaadr '(((GOOD)) ((NIGHT)))) )


#2.25 - ignored

#2.26
(test 2 (length (cdr '(A B C))))
# ERROR - (cdr (length '(A B C)))

#2.27 -
#2.28 - ignored

#2.29
(de unary-add1 (L)
   (cons 'X L) )
(test
   '(X X X X)
   (unary-add1 '(X X X)) )

#2.30
(de sub-two (L)
   (cddr L) )
(test
   (need 3 'X)
   (sub-two '(X X X X X)) )

#2.31
(de unary-zerop (L)
   (not L) )
(test
   NIL
   (unary-zerop '(X X X)) )
(test
   T
   (unary-zerop '()) )

#2.32
(de unary-greaterp (L1 L2)
   (> (length L1) (length L2)) )
(test
   T
   (unary-greaterp '(X X X) '(X)) )

#2.33 - ignored

#2.34
(de 2-34 (A B C D)
   (cons A (cons B (cons C D))) )
(test
   (1 2 3 . 4)
   (2-34 1 2 3 4) )

#2.35
(de 2-35 (A B C D)
   (list (cons A B) (cons C D)) )
(test
   '((1 . 2) (3 . 4))
   (2-35 1 2 3 4) )

#2.36 - ignored

