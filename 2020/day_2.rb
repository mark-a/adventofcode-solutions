valid = open("input_2").read.each_line.select do |line|
	range_str, letter_str, testword = line.split(" ")
	letter = letter_str[0]
	range = Range.new *(
						range_str.split("-")
						.map(&:to_i)
					    )
	range.include? testword.count(letter)
end

puts "Step 1: #{valid.count} valid"

valid_2 = open("input_2").read.each_line.select do |line|
	range, letter_str, testword = line.split(" ")
	letter = letter_str[0]
	test_1, test_2 = range.split("-")
						  .map(&:to_i)
						  .map{ |index| testword[index -1] == letter }
    test_1 ^ test_2
end

puts "Step 2: #{valid_2.count} valid"