# 13aug23 Software Lab. Alexander Burger

(tracks '*Plan)

              |
              |
         /    |                   ----------
        /    /|                  /          \
       |    / |\                /            \
       |   /  | \              |              |
-----------------------------  |              |
       |    \ |  /             |              |
             \| /               \            /
              |/                 \          /
              |                   ----------
              |
              |

      ----------
     /          \
    /            \
   |              |
   |              |
   |              |
    \            /
     \          /
      ----------

(new '(+Locomotive) (pd 1 7 'a) 0
   (pause)
   (loop
      (drive 8.0 40.0 15 1)
      (turn)
      (drive 8.0 40.0 15 13)
      (turn)
      (drive 8.0 40.0 29 7)
      (turn)
      (drive 8.0 40.0 1 7)
      (turn) ) )

(new '(+Locomotive) (pd 35 3 'a) 0
   (pause)
   (loop
      (move> This)
      (pause 0.1) ) )

(new '(+Locomotive) (pd 16 15 'b) 0
   (pause)
   (loop
      (move> This)
      (pause 0.25) ) )
