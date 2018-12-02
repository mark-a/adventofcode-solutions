filename = ARGV.first
txt = open(filename)

twos = 0
threes = 0

txt.read.each_line do |line|
	count = {}
	line.split('').each do |char|
		if count[char]
			count[char]+=1
		else
			count[char]=1
		end
	end
	add_two = false
	add_three = false
	count.to_a.each do |key,value|
		if value == 3
			add_three= true
		elsif value == 2
			add_two = true
		end
	end
	if add_two 
		twos+=1
	end
	if add_three
		threes+=1
	end
end

puts twos * threes;