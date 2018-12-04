filename = ARGV.first
txt = open(filename)

lines = txt.read.each_line.map(&:chomp)
bytesize = lines.each.map(&:size).sum
size = lines.each.map{|str| eval(str).size}.sum

puts bytesize - size