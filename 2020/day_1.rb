numbers = open("input_1").map(&:to_i)

numbers.combination(2).each do |first, second|
	puts "Step 1: found: #{first * second}" if first + second == 2020
end


numbers.combination(3).each do |first, second, third|
	puts "Step 2: found: #{first * second * third}" if first + second + third == 2020
end