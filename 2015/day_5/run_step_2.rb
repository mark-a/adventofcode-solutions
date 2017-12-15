filename = ARGV.first
txt = open(filename)

nice = 0
txt.read.each_line do |line|

  doubles = line.scan(/(.{2})(.*)\1{1}/).count
  repeats = line.scan(/(.){1}(.){1}\1{1}/).count

  if repeats > 0 and doubles > 0
    nice += 1
  end

end

puts "number of nice words: "+ nice.to_s