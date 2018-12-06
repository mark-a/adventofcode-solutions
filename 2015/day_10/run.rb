#shamelessly copied from rosetta code
def lookandsay(str)
  str.chars.chunk{|c| c}.map{|c,x| [x.size, c]}.join
end
 
num = "3113322113"
50.times do |t|
  num = lookandsay(num)
  puts "#{t+1}: #{num.size}"
end