filename = ARGV.first
txt = open(filename)

fabric = Array.new(1000) {Array.new(1000,0)}
intact = {}

txt.read.each_line.with_index do |line|
	parts = line.split('@')
	id = parts[0][1..parts[0].length].to_i      
	entry_parts = parts[1].split(':')
	coords = entry_parts[0].split(',').map(&:to_i)
	dims = entry_parts[1].split('x').map(&:to_i)
	intact[id] = true
	for x in 0..(dims[0]-1)
		for y in 0..(dims[1]-1)
			if fabric[coords[0]+x][coords[1]+y] != 0
				intact[fabric[coords[0]+x][coords[1]+y]] = false
				intact[id] = false
			end
			fabric[coords[0]+x][coords[1]+y] = id
		end
	end
		
end

puts intact.to_a.select{|key,value| value == true}.inspect;