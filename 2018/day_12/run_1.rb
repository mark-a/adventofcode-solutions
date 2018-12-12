filename = ARGV.first
txt = open(filename)

BUFFER = 20
states = []
states += Array.new(BUFFER){'.'}

rules = {}
txt.read.each_line.with_index do |line, index|
	if index == 0
		states_str = line.chomp.delete "initial state: "
		states_str.split('').each do |char|
			states.push char
		end
	elsif index > 1
		parts = line.chomp.split(" => ")
		from = parts[0]
		to = parts[1]
		rules[from] = to
	end
end

states += Array.new(BUFFER){'.'}
states += Array.new(BUFFER){'.'}
	
	
20.times do
	new_states = Array.new(states.size){'.'}
	states.each.with_index do |state, index|
		if index < 2
			next
		end
		pattern = states[index-2,5].join('')
		if rules[pattern]
			new_states[index] = rules[pattern]
		else
			new_states[index] = '.'
		end
	end
	states = new_states
end
puts states.join


sum = 0
states.each.with_index do |state,index|
	if state == "#"
		sum += index - BUFFER
	end
end

puts sum
