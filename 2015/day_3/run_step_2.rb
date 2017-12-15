filename = ARGV.first
txt = open(filename)

x_1= 0
y_1= 0

x_2= 0
y_2= 0

grid = {}
grid[ x_1.to_s + ":" + y_1.to_s] = 2

flip_flop = false

txt.read.each_char.with_index do |char,index|
  case char
    when '>'
      flip_flop ? x_1 += 1 : x_2 += 1
    when '<'
      flip_flop ? x_1 -= 1 : x_2 -= 1
    when '^'
      flip_flop ? y_1 -= 1 : y_2 -= 1
    when 'v'
      flip_flop ? y_1 += 1 : y_2 += 1
  end

  if flip_flop
    pos = grid[ x_1.to_s + ":" + y_1.to_s]
    if pos == nil
      grid[ x_1.to_s + ":" + y_1.to_s] = 1
    else
      grid[ x_1.to_s + ":" + y_1.to_s] += 1
    end
  else
    pos = grid[ x_2.to_s + ":" + y_2.to_s]
    if pos == nil
      grid[ x_2.to_s + ":" + y_2.to_s] = 1
    else
      grid[ x_2.to_s + ":" + y_2.to_s] += 1
    end
  end

  flip_flop = !flip_flop
end

puts "number of houses: "+ grid.keys.length.to_s

