# Task: 24 game/Solve
(be play24 (@Lst @Expr)
   (permute @Lst (@A @B @C @D))
   (member @Op1 (+ - * /))
   (member @Op2 (+ - * /))
   (member @Op3 (+ - * /))
   (or
      ((equal @Expr (@Op1 (@Op2 @A @B) (@Op3 @C @D))))
      ((equal @Expr (@Op1 @A (@Op2 @B (@Op3 @C @D))))) )
   (^ @ (= 24 (catch '("Div/0") (eval (-> @Expr))))) )
(de play24 (A B C D)
   (solve
      (quote
         @L (list A B C D)
         (play24 @L @X) ) ) )
(test
   (quote
      ((@L 5 6 7 8) (@X * (+ 5 7) (- 8 6)))
         ((@L 5 6 7 8) (@X * 6 (+ 5 (- 7 8)))) 
         ((@L 5 6 7 8) (@X * 6 (- 5 (- 8 7)))) 
         ((@L 5 6 7 8) (@X * 6 (- 5 (/ 8 7)))) 
         ((@L 5 6 7 8) (@X * 6 (+ 7 (- 5 8)))) 
         ((@L 5 6 7 8) (@X * 6 (- 7 (- 8 5)))) 
         ((@L 5 6 7 8) (@X * 6 (/ 8 (- 7 5)))) 
         ((@L 5 6 7 8) (@X / (* 6 8) (- 7 5)))
         ((@L 5 6 7 8) (@X * (+ 7 5) (- 8 6))) 
         ((@L 5 6 7 8) (@X * (- 8 6) (+ 5 7))) 
         ((@L 5 6 7 8) (@X * (- 8 6) (+ 7 5))) 
         ((@L 5 6 7 8) (@X * 8 (/ 6 (- 7 5)))) 
         ((@L 5 6 7 8) (@X / (* 8 6) (- 7 5))) )
   (play24 5 6 7 8) )


# Task: List comprehensions
(be pythag (@N @X @Y @Z)
   (for @X @N)
   (for @Y @X @N)
   (for @Z @Y @N)
   (^ @
      (let (X (-> @X)  Y (-> @Y)  Z (-> @Z))
          (= (+ (* X X) (* Y Y)) (* Z Z)) ) ) )
(test
   (quote
      ((@X . 3) (@Y . 4) (@Z . 5)) ((@X . 5) (@Y . 12) (@Z . 13)) 
      ((@X . 6) (@Y . 8) (@Z . 10)) ((@X . 8) (@Y . 15) (@Z . 17)) 
      ((@X . 9) (@Y . 12) (@Z . 15)) ((@X . 12) (@Y . 16) (@Z . 20)) )
   (solve '((pythag 20 @X @Y @Z))) )


# Task: Zebra puzzle
(be match (@House @Person @Drink @Pet @Cigarettes)
   (permute (red blue green yellow white) @House)
   (left-of @House white  @House green)

   (permute (Norwegian English Swede German Dane) @Person)
   (has @Person English  @House red)
   (equal @Person (Norwegian . @))
   (next-to @Person Norwegian  @House blue)

   (permute (tea coffee milk beer water) @Drink)
   (has @Drink tea  @Person Dane)
   (has @Drink coffee  @House green)
   (equal @Drink (@ @ milk . @))

   (permute (dog birds cats horse zebra) @Pet)
   (has @Pet dog  @Person Swede)

   (permute (Pall-Mall Dunhill Blend Blue-Master Prince) @Cigarettes)
   (has @Cigarettes Pall-Mall  @Pet birds)
   (has @Cigarettes Dunhill  @House yellow)
   (next-to @Cigarettes Blend  @Pet cats)
   (next-to @Cigarettes Dunhill  @Pet horse)
   (has @Cigarettes Blue-Master  @Drink beer)
   (has @Cigarettes Prince  @Person German)

   (next-to @Drink water  @Cigarettes Blend) )
(be has ((@A . @X) @A (@B . @Y) @B))
(be has ((@ . @X) @A (@ . @Y) @B)
   (has @X @A @Y @B) )
(be right-of ((@A . @X) @A (@ @B . @Y) @B))
(be right-of ((@ . @X) @A (@ . @Y) @B)
   (right-of @X @A @Y @B) )
(be left-of ((@ @A . @X) @A (@B . @Y) @B))
(be left-of ((@ . @X) @A (@ . @Y) @B)
   (left-of @X @A @Y @B) )
(be next-to (@X @A @Y @B) (right-of @X @A @Y @B))
(be next-to (@X @A @Y @B) (left-of @X @A @Y @B))
(test
   (quote
      ((@House yellow blue red green white) 
         (@Person Norwegian Dane English German Swede) 
         (@Drink water tea milk coffee beer) 
         (@Pet cats horse birds zebra dog) 
         (@Cigarettes Dunhill Blend Pall-Mall Prince Blue-Master) ) )
   (solve '((match @House @Person @Drink @Pet @Cigarettes)) ) )


# Task: Amb
(be amb (@E @Lst)
   (lst @E @Lst) )
(be joins (@Left @Right)
   (^ @T (last (chop (-> @Left))))
   (^ @R (car (chop (-> @Right))))
   (or
      ((equal @T @R))
      ((amb @ NIL)) ) ) 
(be ambExample ((@Word1 @Word2 @Word3 @Word4))
  (amb @Word1 ("the" "that" "a"))
  (amb @Word2 ("frog" "elephant" "thing"))
  (amb @Word3 ("walked" "treaded" "grows"))
  (amb @Word4 ("slowly" "quickly"))
  (joins @Word1 @Word2)
  (joins @Word2 @Word3)
  (joins @Word3 @Word4) )
(test
   '(((@Result "that" "thing" "grows" "slowly")))
   (solve '((ambExample @Result))) )


# Task: Dinesman's multiple-dwelling problem
(be dwelling (@Tenants)
   (permute (Baker Cooper Fletcher Miller Smith) @Tenants)
   (not (topFloor Baker @Tenants))
   (not (bottomFloor Cooper @Tenants))
   (not (or ((topFloor Fletcher @Tenants)) ((bottomFloor Fletcher @Tenants))))
   (higherFloor Miller Cooper @Tenants)
   (not (adjacentFloor Smith Fletcher @Tenants))
   (not (adjacentFloor Fletcher Cooper @Tenants)) )
(be topFloor (@Tenant @Lst)
   (equal (@ @ @ @ @Tenant) @Lst) )
(be bottomFloor (@Tenant @Lst)
   (equal (@Tenant @ @ @ @) @Lst) )
(be higherFloor (@Tenant1 @Tenant2 @Lst)
   (append @ @Rest @Lst)
   (equal (@Tenant2 . @Higher) @Rest)
   (member @Tenant1 @Higher) )
(be adjacentFloor (@Tenant1 @Tenant2 @Lst)
   (append @ @Rest @Lst)
   (or
      ((equal (@Tenant1 @Tenant2 . @) @Rest))
      ((equal (@Tenant2 @Tenant1 . @) @Rest)) ) )
(test
   '(((@Result Smith Cooper Baker Fletcher Miller)))
   (solve '((dwelling @Result))) )


# Task: Pascal's triangle/Puzzle
(be number (@N @Max)
   (^ @C (box 0))
   (repeat)
   (or
      ((^ @ (>= (val (-> @C)) (-> @Max))) T (fail))
      ((^ @N (inc (-> @C)))) ) )
(be + (@A @B @Sum)
   (^ @ (-> @A))
   (^ @ (-> @B))
   (^ @Sum (+ (-> @A) (-> @B))) )
(be + (@A @B @Sum)
   (^ @ (-> @A))
   (^ @ (-> @Sum))
   (^ @B (- (-> @Sum) (-> @A)))
   T
   (^ @ (ge0 (-> @B))) )
(be + (@A @B @Sum)
   (number @A @Sum)
   (^ @B (- (-> @Sum) (-> @A))) )

#{
         151
        A   B
      40  C   D
     E  F  G    H
   X  11  Y   4   Z
}#

(be puzzle (@X @Y @Z)
   (+ @A @B 151)
   (+ 40 @C @A)
   (+ @C @D @B)
   (+ @E @F 40)
   (+ @F @G @C)
   (+ @G @H @D)
   (+ @X 11 @E)
   (+ 11 @Y @F)
   (+ @Y 4 @G)
   (+ 4 @Z @H)
   (+ @X @Z @Y)
   T )
(test
   '(((@X . 5) (@Y . 13) (@Z . 8)))
   (solve '((puzzle @X @Y @Z))) )


# Task: Pattern matching
(be color (R))
(be color (B))
(be tree (@ E))
(be tree (@P (T @C @L @X @R))
   (color @C)
   (tree @P @L)
   (call @P @X)
   (tree @P @R) )
(be bal (B (T R (T R @A @X @B) @Y @C) @Z @D (T R (T B @A @X @B) @Y (T B @C @Z @D))))
(be bal (B (T R @A @X (T R @B @Y @C)) @Z @D (T R (T B @A @X @B) @Y (T B @C @Z @D))))
(be bal (B @A @X (T R (T R @B @Y @C) @Z @D) (T R (T B @A @X @B) @Y (T B @C @Z @D))))
(be bal (B @A @X (T R @B @Y (T R @C @Z @D)) (T R (T B @A @X @B) @Y (T B @C @Z @D))))
(be balance (@C @A @X @B @S)
   (bal @C @A @X @B @S)
   T )
(be balance (@C @A @X @B (T @C @A @X @B)))
(be ins (@X E (T R E @X E)))
(be ins (@X (T @C @A @Y @B) @R)
   (^ @ (> (-> @Y) (-> @X)))
   (ins @X @A @Ao)
   (balance @C @Ao @Y @B @R)
   T )
(be ins (@X (T @C @A @Y @B) @R)
   (^ @ (> (-> @X) (-> @Y)))
   (ins @X @B @Bo)
   (balance @C @A @Y @Bo @R)
   T )
(be ins (@X (T @C @A @Y @B) (T @C @A @Y @B)))
(be insert (@X @S (T B @A @Y @B))
   (ins @X @S (T @ @A @Y @B)) )
(test
   '(((@A T B E 2 E) (@B T B (T R E 1 E) 2 E) (@C T B (T R E 1 E) 2 (T R E 3 E))))
   (solve '((insert 2 E @A) (insert 1 @A @B) (insert 3 @B @C))) )

(msg 'Pilog-rosetta-OK)
(bye)
