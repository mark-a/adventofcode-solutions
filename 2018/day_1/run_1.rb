filename = ARGV.first
txt = open(filename)

value = 0

txt.read.each_line.with_index do |line,index|
	change = line.to_i
	value += change
end

puts value;