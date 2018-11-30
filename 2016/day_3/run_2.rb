filename = ARGV.first
txt = open(filename)

impossibles = 0

column_1 = []
column_2 = []
column_3 = []

txt.read.each_line.with_index do |line,index|
	numbers = line.split(" ").map(&:to_i)
	column_1.push numbers[0]
	column_2.push numbers[1]
	column_3.push numbers[2]
end

lengths = column_1 + column_2 + column_3

lengths.each_slice(3) do |parts|
	sides = parts.sort
	if sides[2] < sides[0] + sides[1]
		impossibles+=1
	end
end


puts impossibles;
