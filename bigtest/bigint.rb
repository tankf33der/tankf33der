
puts("mike")
#s = STDIN.gets.split(" ")
#s[0] = s[0].to_i
#puts s[0] + 100

while s = STDIN.gets.split(" ")
	s[0] = s[0].to_i
	s[2] = s[2].to_i

	case s[1]
	when "+"
		puts(s[0] + s[2])
	when "-"
		puts(s[0] - s[2])
	when "*"
		puts(s[0] * s[2])
	when "/"
		puts(s[0] / s[2])
	when "%"
		puts(s[0] % s[2])
	when "&"
		puts(s[0] & s[2])
	when "|"
		puts(s[0] | s[2])
	when "xor"
		puts(s[0] ^ s[2])
	when "<<"
		puts(s[0] << s[2])
	when ">>"
		puts(s[0] >> s[2])
	end
end


