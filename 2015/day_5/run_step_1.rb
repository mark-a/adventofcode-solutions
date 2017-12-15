filename = ARGV.first
txt = open(filename)

nice = 0
txt.read.each_line do |line|
  vowels = line.scan(/[aeiou]/).count
  doubles = line.scan(/(.)\1/).count
  naughties = line.scan(/ab|cd|pq|xy/).count

  if vowels > 2 and doubles > 0 and naughties == 0
    nice += 1
  end

end

puts "number of nice words: "+ nice.to_s