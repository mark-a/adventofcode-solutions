require_relative '../shared/intcode'

filename = ARGV.first
txt = open(filename)

input = txt.read.split(",").map(&:to_i)
ic = Intcode.new(input)

ic.process(5)
puts ic.output
