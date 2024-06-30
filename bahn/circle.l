# 13aug23 Software Lab. Alexander Burger

(tracks '*Plan)

              |     |
           ---|-----|---
          /   |     |   \
         /    |     |    \
        /    /|     |     \
       |    / |\    |      |
       |   /  | \   |      |
   ----|------------|------|--
       |    \ |  /         |
       |     \| /          |
        \     |/          /
         \    |          /
          \   |         /
           ---|---------
              |

(new '(+Locomotive) (pd 4 8 'a) 0
   (pause)
   (loop
      (drive 8.0 40.0 15 1)
      (turn)
      (drive 8.0 40.0 15 15)
      (turn)
      (drive 8.0 40.0 30 8)
      (turn)
      (drive 8.0 40.0 4 8)
      (turn) ) )

(new '(+Locomotive) (pd 12 2 'a) 5
   (pause)
   (loop
      (move> This)
      (pause 0.5) ) )

(new '(+Locomotive) (pd 24 14 'b) 5
   (pause)
   (loop
      (move> This)
      (pause 0.5) ) )

