path = ARGV.first
content = File.read path


routes = {} of  Tuple(String, String) => Int32
locations = [] of String

content.each_line do |line|
	parts = line.split(" to ")
	other_parts = parts[1].split(" = ")
	from = parts[0]
	to = other_parts[0]
	costs = other_parts[1].to_i
	
	locations.push to unless locations.includes? to
	locations.push from unless locations.includes? from
	
	routes[{from,to}] = costs
	routes[{to,from}] = costs
end

smallest = Int32::MAX 
biggest = Int32::MIN 

locations.permutations(locations.size).each do |try_path|
	current = nil
	current_costs = 0
	try_path.each do |stop| 
		if current
			current_costs += routes[{current,stop}]
		end
		current = stop 
	end
	if current_costs < smallest
		smallest = current_costs
	end
	if current_costs > biggest
		biggest = current_costs
	end
end


puts "shortest: #{smallest}"
puts "longest: #{biggest}"