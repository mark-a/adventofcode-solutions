filename = ARGV.first
txt = open(filename)

impossibles = 0

txt.read.each_line.with_index do |line,index|
	sides = line.split(" ").map(&:to_i).sort!
	if sides[2] < sides[0] + sides[1]
		impossibles+=1
	end
end

puts impossibles;
