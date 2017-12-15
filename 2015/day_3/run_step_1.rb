filename = ARGV.first
txt = open(filename)

x= 0
y= 0
number_of_presents = 0

grid = {}

grid[ x.to_s + ":" + y.to_s] = 1

txt.read.each_char.with_index do |char,index|
  case char
    when '>'
      x += 1
    when '<'
      x -= 1
    when '^'
      y -= 1
    when 'v'
      y += 1
  end
  pos = grid[ x.to_s + ":" + y.to_s]
  if pos == nil
    grid[ x.to_s + ":" + y.to_s] = 1
  else
    grid[ x.to_s + ":" + y.to_s] += 1
  end
end

puts "number of houses: "+ grid.keys.length.to_s

