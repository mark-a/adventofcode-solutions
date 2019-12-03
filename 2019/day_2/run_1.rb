filename = ARGV.first
txt = open(filename)

set = []
txt.read.each_line.with_index do |line,index|
  values = line.split(',').reject { |c| c == "\n" }.map(&:to_i)
  set += values
end


set[1] = 12
set[2] = 2


index = 0
while  set[index] != 99 do
if  set[index] == 1
	set[set[index+3]] = set[set[index+1]] + set[set[index+2]]
elsif  set[index] == 2
	set[set[index+3]] = set[set[index+1]] * set[set[index+2]]
else
	raise "Illegal opcode #{ set[index]}"
end
	index += 4
end



puts set[0]