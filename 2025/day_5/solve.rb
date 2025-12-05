input = open("input").read

fresh = []
list = []

switch = false
input.each_line do |line|
  if line == "\n"
    switch = true
  elsif switch
    list.push line.strip.to_i
  else
      range_start, range_end = line.strip.split("-").map(&:to_i)
      fresh.push (range_start..range_end)
  end
end

puts "Part 1: #{list.count{|entry| fresh.any?{|fresh_list| fresh_list.include? entry}  }}"

def any_overlaps?(ranges)
  ranges.each_with_index do |range1, i|
    ranges.each_with_index do |range2, j|
      return [range1, range2] if i != j && range1.overlap?(range2)
    end
  end
  [nil,nil]
end

def merge_ranges(a, b)
  [a.begin, b.begin].min..[a.end, b.end].max
end

a, b = any_overlaps?(fresh)
while a && b
  fresh.delete a
  fresh.delete b
  fresh.push merge_ranges(a,b)

  a, b = any_overlaps?(fresh)
end

sum = 0
fresh.each do |range|
  sum += range.count
end

puts "Part 2: #{sum}"