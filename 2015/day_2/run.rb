filename = ARGV.first
txt = open(filename)

wrapping_total = 0
ribbon_total = 0

txt.read.each_line.with_index do |line,index|
  dims = line.split("x")
  l = dims[0].to_i
  w = dims[1].to_i
  h = dims[2].to_i
  sides = [l*w,l*w, w*h,w*h ,h*l,h*l]

  wrapping = sides.min + sides.inject(0, :+)
  wrapping_total += wrapping

  ribbon = [l,l,w,w,h,h].sort[0..3].inject(0, :+)
  bow = l * w * h
  ribbon_total += ribbon + bow
end

puts "wrapping: "+ wrapping_total.to_s + " feet"
puts "ribbon: "+ ribbon_total.to_s + " feet"