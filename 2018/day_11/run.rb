serial = 7347

power_levels = Array.new(300){Array.new(300){0}}
coords = []
(0...300).each do |x|
  (0...300).each do |y|
    rack = x + 10
    cell_power = (rack * y + serial) * rack
    cell_power = (cell_power / 100) % 10
    power_levels[x][y] = cell_power - 5
	coords.push [x,y]
  end
end

puts coords.max_by { |x, y|
  power_levels[x, 3].sum { |slice| slice[y, 3].sum }
}.join(',')


current_max_power = -64000
current_solution = ".,.,."

# do we need to search all 300 sizes?
(1..50).each do |size|
	max_coords = coords.max_by { |x, y|
	  power_levels[x, size].sum { |row| row[y, size].sum }
	}
	local_max = power_levels[max_coords[0], size].sum { |slice| slice[max_coords[1], size].sum }
	if local_max > current_max_power
		current_max_power = local_max
		current_solution = max_coords.push(size).join(',')
	end
end

puts current_solution
