list_1 = []
list_2 = []

input = open("input").read

input.each_line do |line|
	first, last = line.split(" ").map(&:to_i)
	list_1.push first
	list_2.push last
end

pairs = list_1.sort.zip list_2.sort
sum = pairs.map{|x,y| (x-y).abs}.sum

puts "Part 1: #{sum}"

score = 0

lookup = list_2.tally
list_1.each do |num|
	score += num * (lookup[num] || 0)
end


puts "Part 2: #{score}"
