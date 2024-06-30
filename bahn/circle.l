# 13aug23 Software Lab. Alexander Burger

(tracks '*Plan)

              |
           -------
          /   |   \
         /    |    \
        /    /|     \
       |    / |\     |
       |   /  | \    |
   ----|-------------|----
       |    \ |  /   |
       |     \| /    |
        \     |/    /
         \    |    /
          \   |   /
           -------
              |

(new '(+Locomotive) (pd 4 8 'a) 0
   (pause)
   (loop
      (drive 8.0 40.0 15 1)
      (turn)
      (drive 8.0 40.0 15 15)
      (turn)
      (drive 8.0 40.0 26 8)
      (turn)
      (drive 8.0 40.0 4 8)
      (turn) ) )
