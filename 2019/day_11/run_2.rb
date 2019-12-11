require_relative '../shared/intcode'

def left((dy, dx))
  # (-1, 0) -> (0, -1) -> (1, 0) -> (0, 1) -> (-1, 0)
  [-dx, dy]
end

def right((dy, dx))
  # (-1, 0) -> (0, 1) -> (1, 0) -> (0, -1) -> (-1, 0)
  [dx, -dy]
end

PAINTED = Hash.new()

filename = ARGV.first
txt = open(filename)

input = txt.read.split(",").map(&:to_i)

position = [0, 0]
# start white
PAINTED[position] = 1
direction = [-1, 0]

ic = Intcode.new(input)

until ic.halted?
  input = PAINTED[position] == 1 ? 1 : 0
  ic.process(input)

  colour, turn = ic.output.shift(2)

  if colour == 1
      PAINTED[position] = 1
  else
      PAINTED[position] = 0
  end

  if turn == 1
    direction = right(direction)
  else
    direction = left(direction)
  end

  position = position.zip(direction).map(&:sum)
end

white = PAINTED.select{|key,value| value == 1}
y = white.keys.to_a.map{|x|x[0]}.sort
x = white.keys.to_a.map{|y|y[1]}.sort

(y.first..y.last).each do |y|
 (x.first..x.last).each do |x|
    if PAINTED[[y, x]] == 1
      print "#"
    else
      print " "
    end
  end
  puts
end