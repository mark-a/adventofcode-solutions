filename = ARGV.first
txt = open(filename)

fabric = Array.new(1000) {Array.new(1000,0)}

txt.read.each_line.with_index do |line|
	parts = line.split('@')
	id = parts[0]
	entry_parts = parts[1].split(':')
	coords = entry_parts[0].split(',').map(&:to_i)
	dims = entry_parts[1].split('x').map(&:to_i)
	for x in 0..(dims[0]-1)
		for y in 0..(dims[1]-1)
			fabric[coords[0]+x][coords[1]+y] += 1
		end
	end
		
end

puts fabric.flatten.select{|x| x > 1}.size;