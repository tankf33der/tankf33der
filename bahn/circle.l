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

(new '(+Locomotive) (pd 15 8 'a) 0
   (pause)
   (loop
      (drive 8.0 40.0 15 8)
      (turn)
#      (drive 8.0 40.0 15 15)
#      (turn)
#      (drive 8.0 40.0 29 7)
#      (turn)
#      (drive 8.0 40.0 1 7)
#      (turn)
      ) )

