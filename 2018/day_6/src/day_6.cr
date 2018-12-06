path = ARGV.first
content = File.read path

points = [] of Tuple(Int32,Int32)

content.each_line do |line|
	parts = line.split(", ")
	x = parts[0].to_i
	y = parts[1].to_i

	points.push({x,y})
end


x_edges = points.map{|tuple| tuple[0]}.minmax
y_edges = points.map{|tuple| tuple[1]}.minmax

x_range = x_edges[0]..x_edges[1]
y_range = y_edges[0]..y_edges[1]

# x,y => index_of_owner, best_distance
shortest_distance_map = {} of Tuple(Int32,Int32) => Tuple(Int32,Int32)

infinites = [] of Int32
excludes = [] of Tuple(Int32,Int32)
total_distance_constain_counter = 0

x_range.each do |x|
	y_range.each do |y| 
		shortest_distance_map[{x,y}] = {-1,Int32::MAX}
		total_distance = 0
		
		points.each_with_index  do |(p_x, p_y), i|
			distance = (p_x - x).abs + (p_y - y).abs
			if distance < shortest_distance_map[{x,y}][1]
				shortest_distance_map[{x,y}] = {i,distance}
				excludes.delete({x,y})
			elsif distance == shortest_distance_map[{x,y}][1]
				excludes.push({x,y})
			end
			total_distance += distance
		end
		best = shortest_distance_map[{x,y}]
		if  points[best[0]][0] == x_edges[0] || 
			points[best[0]][0] == x_edges[1] ||
			points[best[0]][1] == y_edges[0] ||
			points[best[0]][1] == y_edges[1] 
			if !infinites.includes? best[0]
				infinites.push best[0]
			end
		end
		if total_distance < 10000
		    total_distance_constain_counter += 1
		end
	end
end

counter = {} of Int32 => Int32
shortest_distance_map.each do |(x,y),(best,_)|
	unless excludes.includes?({x,y})
		if counter[best]?
			counter[best] += 1
		else
			counter[best] = 1
		end
	end
end

puts counter.to_a.select{|key,_|!infinites.includes? key}.sort{|a,b| b[1]<=>a[1]}.first[1]
puts total_distance_constain_counter
