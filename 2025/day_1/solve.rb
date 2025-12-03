input = open("input").read

zeros = 0
dial = 50
input.each_line do |line|
  direction = line[0]
  amount = line[1..].to_i
  if direction == "R"
    dial += amount
  else
    dial -= amount
  end
  dial = dial % 100
  zeros += 1 if dial == 0
end

puts "Part 1: #{zeros}"

zeros = 0
dial = 50
input.each_line do |line|
  direction = line[0]
  amount = line[1..].to_i
  if direction == "R"
    zeros += 1 if dial < 0 && amount >= dial.abs
    dial += amount
  else
    zeros += 1 if dial > 0 && amount >= dial.abs
    dial -= amount
  end
  zeros += dial.abs / 100
  dial = dial % 100
end

puts "Part 2: #{zeros}"
