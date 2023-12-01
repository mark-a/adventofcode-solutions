sum = 0

input = open("input").read

input.each_line do |line|
  numbers = line.scan /\d/
  sum += Integer("#{numbers.first}#{numbers.last}")
end

puts "Part 1: #{sum}"

sum_2 = 0

def lookup(string)
	{
		"one" => 1,
		"two" => 2,
		"three" => 3,
		"four" => 4,
		"five" => 5,
		"six" => 6,
		"seven" => 7,
		"eight" => 8,
		"nine" => 9
	}[string]
end

input.each_line.with_index do |line,index|
  # ?= lookahead for overlapping strings
  numbers = line.scan(/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/)
  
  slots = [numbers.first, numbers.last].map do |capture|
	find = capture.first
	result = Integer(find, exception: false)
	result = lookup(find) if result.nil?
	result
  end
  
  sum_2 += Integer("#{slots.first}#{slots.last}")
end

puts "Part 2: #{sum_2}"