# 22mar10abu
# (c) Software Lab. Alexander Burger
 
(for N 503  # Start all 503 threads
   (let (Recv (tmp N)  Send (tmp (if (= 503 N) 1 (inc N))))
      (call 'mkfifo Recv)
      (unless (fork)  # In child process:
         (in Recv
            (out Send
               (loop
                  (NIL (rd))
                  (NIL (gt0 @)  # Done
                     (out NIL (println N))  # Print result to stdout
                     (kill *PPid) )  # Stop parent
                  (pr (dec @))
                  (flush) ) ) )
         (bye) ) ) )
 
(out (tmp 1)  # Inject first token into the ring
   (pr (format (opt)))  # as given by command line argument
   (flush)
   (wait) )  # Wait for signal

