(let (X 1  Y 2  Z 3)
	(swap 'X (swap 'Z (swap 'Y X)))
	(println 'X X 'Y Y 'Z Z) )

# 4 vars
# A B C D
# B -> A
# C -> B
# D -> C
# A -> D

# after run should be 
# A 2 
# B 3
# C 4
# D 1
(prinl)
(let (A 1  B 2  C 3  D 4)
   (println 'A A 'B B 'C C 'D D)
   (swap 'A (swap 'B (swap 'C (swap 'D A))))
   (println 'A A 'D B 'C C 'D D) )
(bye)

