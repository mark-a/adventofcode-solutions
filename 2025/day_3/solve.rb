input = open("input").read

sum = 0
input.each_line do |line|
  joltages = line.strip.split('').map.with_index do |char, index|
    num = char.to_i
    [num, index]
  end

  first = joltages[...joltages.size - 1].sort_by { |j| [-j[0], j[1]] }.first
  second = joltages[(first[1] + 1)..].sort_by { |j| [-j[0], j[1]] }.first

  sum += "#{first[0]}#{second[0]}".to_i
end

puts "Part 1: #{sum}"


input = open("input").read

sum = 0
input.each_line do |line|
  joltages = line.strip.split('').map.with_index do |char, index|
    num = char.to_i
    [num, index]
  end

  solution = []
  last = joltages[...joltages.size - 12].sort_by { |j| [-j[0], j[1]] }.first
  solution.push last[0]
  11.times.to_a.reverse.each do |index|
    best_range = ((last[1] + 1)..(joltages.size - index - 1))
    last = joltages[best_range].sort_by { |j| [-j[0], j[1]] }.first
    solution.push last[0] if last
  end

  sum += solution.join("").to_i
end

puts "Part 2: #{sum}"
