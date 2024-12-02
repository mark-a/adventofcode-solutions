correct = 0

def asc? arr
  arr == arr.sort
end

def dec? arr
  arr == (arr.sort.reverse)
end

def safe? numbers
  if asc?(numbers) || dec?(numbers)
    flag = true
    numbers.each_cons(2) { |current, prev|
      diff = (current - prev).abs
      if diff < 1 || diff > 3
        flag = false
      end
    }
    flag
  else
    false
  end
end

input = open("input").read

input.each_line do |line|
  numbers = line.split(" ").map { |x| Integer(x) }
  if safe? numbers
    correct += 1
  end
end

puts "Part 1: #{correct}"

correct_2 = 0

input.each_line do |line|
  numbers = line.split(" ").map { |x| Integer(x) }
  if safe? numbers
    correct_2 += 1
  else
    flag = false
    (0...numbers.length).each do |index|
      clone = numbers.clone
      clone.delete_at(index)
      flag = true if safe? clone
    end
    correct_2 += 1 if flag
  end
end

puts "Part 2: #{correct_2}"

