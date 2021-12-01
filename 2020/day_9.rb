numbers =  open("input_9").map(&:to_i)


index = 0
test_num = 0
step = 25

(step...numbers.size).each do |i|
  index = i
  test_num = numbers[i]

  candidates = numbers[i - step...i]
  break if candidates.combination(2).find { |pair| pair.sum == test_num } == nil
end
puts "Step 1: #{ test_num }"


candidates = numbers[0...index]
contiguous_numbers = nil

# Brute force for looking for contiguous sum of test number.. Is there a better way?
catch :Done do
  (2...candidates.size).each do |len|
    (0...candidates.size).each do |i|
      contiguous_numbers = candidates[i...i + len]
      throw :Done if contiguous_numbers.sum == test_num
    end
  end
end
puts "Step 2: #{ contiguous_numbers.min + contiguous_numbers.max }"