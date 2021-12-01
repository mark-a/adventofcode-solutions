input =  open("input_10").map(&:to_i).sort

maximum = input.max + 3

numbers = input.dup
differences_1 = 0
differences_3 = 0
numbers.unshift 0

numbers.each.with_index do |current, index|
  next_num = numbers[index + 1] || maximum
  case (next_num-current)
  when 1
	differences_1 += 1 
  when 3 
	differences_3 += 1
  end
end

puts "Solution 1: #{differences_1 *differences_3}"


numbers_2 = input.dup
numbers_2.push maximum

counter = Array.new(numbers_2.size){ 0 }
counter[0] = 1

(1..counter.size).each do |index|
  count = 0
  val = numbers_2[index] || maximum
  [1,2,3].each do |diff|
	  search_index = index - diff
	  break if search_index < 0
	  if val - numbers_2[search_index] <= 3
	  	count += counter[search_index] 
	  end
  end

  counter[index] = count
end

puts "Solution 2: #{counter.last}"
