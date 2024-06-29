# 28jan24 Software Lab. Alexander Burger

(tracks '*Plan)

|  |  |              --------------------
|  |  |             /            /       \
|\ |  |            /            /         \
| \|  |           /            /           \
|  |  |          |            |             |
|  |  |          |            |             |
|  |  |          |            |             |
|  |  |          |            |             |
|  | /|          |            |             |
|  |/ |          |            |             |
|  |  |          |           /|             |
| /|  |          |          / |             |
|/ |  |         /          |  |             |
|  |  |        /           |  |             |
|  |          /            |  |             |
|  |         /             |  |             |
|  |        /              |  |             |
|          /               |  |             |
|         /                |  |             |
|        /                 |  |             |  |
|       /                  |\ |             |  |
|      /                   | \|            /|  |
|     |                    |  |           / |  |
|     |                    |  |          |  |  |
|     |\                   |  |          |  |\ |
|     | \                  |  |          |  | \|
|     |  |                /   |          |  |  |
|     |  |               /    |          |  |  |
|     |  |              /     |          |  |  |
|     |  |             /      |          |  |  |
|     |  |            |       |          | /|  |
|     |  |            |       |          |/ |  |
|     | /             |       |          |  |  |
|     |/              |       |          |  |  |
|     |               |       |          |  | /|
|     |               |       |          |  |/ |
|      \             /        |          |  |  |
|       \           /         |          |  |  |
|        \         /          |          |  |  |
|         ---------           |          |  |  |
|                             |          |  |  |
 \                           /           |  |  |
  \                         /            |  |  |
   \                       /             |  |  |
    -----------------------              |  |  |

(new '(+Locomotive) (pd 1 10 'a) 5
   (pause)
   (loop
      (drive 0.2 40.0  31 14)
      (pause 12.0)
      (drive 0.2 40.0  45 34)
      (shunt
         (drive 0.1 10.0  45 38)
         (turn)
         (drive 0.1 10.0  48 32  45 23)
         (turn)
         (drive 0.1 10.0  45 28) )
      (drive 0.2 40.0  31 19)
      (pause 12.0)
      (drive 0.2 40.0  1 4)
      (shunt
         (drive 0.1 10.0  1 1)
         (turn)
         (drive 0.1 10.0  4 8  1 15)
         (turn)
         (drive 0.1 10.0  1 10) ) ) )

(new '(+Locomotive) (pd 42 25 'b) 5
   (pause)
   (loop
      (drive 0.2 40.0  31 5  28 19)
      (pause 12.0)
      (drive 0.2 40.0  7 27)
      (pause 12.0)
      (drive 0.2 40.0  42 31)
      (shunt
         (drive 0.1 10.0  42 34)
         (turn)
         (drive 0.1 10.0  45 20)
         (turn)
         (drive 0.1 10.0  42 25) ) ) )

(new '(+Locomotive) (pd 10 31 'a) 2
   (let Rev (rev> This (pd 10 28 'a))
      (pause)
      (loop
         (drive 0.2 40.0  28 15)
         (pause 12.0)
         (drive 0.2 40.0  48 32)
         (pause 12.0)
         (turn 'Rev)
         (drive 0.1 10.0  48 21)
         (pause 24.0)
         (turn 'Rev)
         (drive 0.1 10.0  48 32)
         (pause 12.0)
         (turn 'Rev)
         (drive 0.2 40.0  10 31)
         (pause 12.0) ) ) )

(new '(+Locomotive) (pd 7 6 'a) 3
   (let Rev (rev> This (pd 7 2 'a))
      (pause)
      (loop
         (drive 0.2 40.0  31 14)
         (pause 12.0)
         (drive 0.2 40.0  48 44)
         (pause 24.0)
         (turn 'Rev)
         (drive 0.2 40.0  31 5  28 19)
         (pause 12.0)
         (drive 0.2 40.0  7 2)
         (pause 24.0)
         (turn 'Rev) ) ) )

(new '(+Locomotive) (pd 7 12 'b) 0
   (pause)
   (loop
      (drive 0.1 10.0  7 6)
      (turn)
      (drive 0.1 10.0  4 14)
      (pause 24.0)
      (turn)
      (drive 0.1 10.0  4 2)
      (pause 24.0)
      (turn)
      (drive 0.3 50.0  45 44)
      (pause 24.0)
      (turn)
      (drive 0.3 50.0  31 16)
      (drive 0.3 50.0  7 6)
      (turn)
      (drive 0.1 10.0  7 12)
      (pause 24.0)
      (turn) ) )
