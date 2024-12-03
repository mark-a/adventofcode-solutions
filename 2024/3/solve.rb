sum = 0

File.readlines("input").each do |line|
  local_muls = line.scan(/mul\((\d{1,3}),(\d{1,3})\)/)
  local_muls.each do |first, second|
    sum += first.to_i * second.to_i
  end
end

puts "Part 1: #{sum}"

sum = 0
add_to_sum = true

File.readlines("input").each do |line|
  local_muls = line.scan(/mul\((\d{1,3}),(\d{1,3})\)|(do)\(\)|(don't)\(\)/)
  local_muls.each do |first, second, third, forth|
    if third == "do"
      add_to_sum = true
    elsif forth == "don\'t"
      add_to_sum = false
    else
      sum += first.to_i * second.to_i if add_to_sum
    end

  end
end

puts "Part 2: #{sum}"