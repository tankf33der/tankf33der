while s = gets
	s = s.split(" ")

	if not s[1]
		puts(s[0])
		next
	end
	
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
