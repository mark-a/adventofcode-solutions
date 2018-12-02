filename = ARGV.first
txt = open(filename)

twos = 0
threes = 0

seen = {}

txt.read.each_line do |line|
	line.each_char.with_index { |c, i|
		alteration = [line[0...i], line[(i + 1)..-1]]
		if seen[alteration]
			puts alteration.join
			break
		end
		seen[alteration] = 1
	  }
end
