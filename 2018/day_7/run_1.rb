filename = ARGV.first
txt = open(filename)


tree= {}

txt.read.each_line do |line|
 parts = line.split(' must be finished before step ')
 before = parts[0].chars.last
 after = parts[1].chars.first
 tree[before] = {  req: [] } unless tree[before]
 tree[after] = { req: [] } unless tree[after]
 tree[after][:req].push before
end

solution = ""

while tree.to_a.size > 0
	selection = tree.to_a.select{|key,value| !value[:req].any? }.sort_by{|key,value| key}.first[0]
	current = tree.delete(selection)
	tree.each do |key,value|
		value[:req].delete selection
	end

	solution += selection
end




puts solution