filename = ARGV.first
txt = open(filename)

lines = txt.read.each_line.map(&:chomp)
orig_size = lines.each.map(&:size).sum
new_size = lines.each.map{|str| str.inspect.size}.sum

puts new_size - orig_size