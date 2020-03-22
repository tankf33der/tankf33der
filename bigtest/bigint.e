include builtins/bigatom.e

/*
object line
object num
while true do
    line = gets(0)
    puts(1, '\n')
    line = line[1..length(line)-1]

    --num = split(line, no_empty:=true)
    --printf(1, "you: %s\n", line)
end while
*/

object line
puts(1, "What is your name?\n")
line = gets(0)  -- read standard input (keyboard)
line = line[1..length(line)-1] -- get rid of \n character at end
puts(1, '\n')   -- necessary
puts(1, line & " is a nice name.\n")

