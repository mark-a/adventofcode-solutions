filename = ARGV.first
txt = open(filename)

open = 0
closed = 0
first_basement = -1

txt.read.each_char.with_index do |char,index|
  if char == '('
    open+=1
  end
  if char == ')'
    closed+=1
  end
  if first_basement == -1 and (open-closed) == -1
    first_basement = index+1
  end
end

puts "At the end on floor "+ (open-closed).to_s
puts "First basement visit at iteration "+ first_basement.to_s