input = open("input").read

spans = []

input.each_line do |line|
  spans = line.split(',').map { |span|
    span.split('-').map(&:to_i)
  }
end

sum = 0
spans.each do |from, to|
  (from..to).each do |number|
    str = number.to_s
    if str.length > 1 && (str.length % 2 == 0)
      first, second = str.chars
                         .each_slice(str.length / 2)
                         .map(&:join)
      if first == second
        sum += number
      end
    end
  end
end

puts "Part 1: #{sum}"

sum = 0
spans.each do |from, to|
  (from..to).each do |number|
    str = number.to_s
    length = str.length
    add = false
    (1..length).each do |index|
      if str.length > 1 && (str.length % index == 0)
        first, *rest = str.chars
                           .each_slice(str.length / index)
                           .map(&:join)
        if rest.any? && rest.all?{|x| x == first}
          add = true
        end
      end
    end
    sum += number if add
  end
end

puts "Part 2: #{sum}"