filename = ARGV.first
txt = open(filename)

changes = []
txt.read.each_line do |line|
	changes.push line.to_i
end

value = 0
value_memory = []
still_looping = true
memory = {}

while still_looping do
	changes.each do |change|
		value += change
		if memory[value]
			still_looping = false
			break
		else
		   memory[value] = 1
		end
	end
end

puts value;