# 22mar10abu
# (c) Software Lab. Alexander Burger
 
(for N 503  # Start all 503 tasks
   (let Recv (tmp N)
      (call 'mkfifo Recv)
      (task (open Recv)
         N N
         Send (tmp (if (= 503 N) 1 (inc N)))
         (in @
            (if (gt0 (rd))
               (out Send (pr (dec @)))
               (println N)  # Print result to stdout
               (bye) ) ) ) ) )  # Exit
 
(out (tmp 1)  # Inject first token into the ring
   (pr (format (opt))) )  # as given by command line argument
(wait)  # Wait to exit

