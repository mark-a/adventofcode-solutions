require_relative '../shared/intcode'

filename = ARGV.first
txt = open(filename)

input = txt.read.split(",").map(&:to_i)
ic = Intcode.new(input)

ic.process([])

blocks = {}

while ic.output.size >= 3
    x, y, tile = ic.output.shift(3)
    if tile == 2
        blocks[[y, x]] = true
    end
end

puts blocks.size