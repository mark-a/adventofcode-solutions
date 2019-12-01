filename = ARGV.first
txt = open(filename)

sum = 0

txt.read.each_line.with_index do |line,index|
  mass = line.to_f
  fuel_req = ((mass / 3.0).floor - 2.0).to_i
  sum += fuel_req
end

puts sum;