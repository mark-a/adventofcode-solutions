#input = 59414
input = 430971
no_digits = input.digits.size
elves = [0,1]
scores = [3, 7]

last = [3, 7]
loop do
	new_recipe = scores[elves[0]] + scores[elves[1]]
	new_recipe.digits.reverse.each do |digit|
		scores.push digit 
		last.push digit
		if last.size > no_digits
			last.shift
			if last.join.to_i  ==  input
				puts scores.size - no_digits 
				return
			end
		end
	end
	elves[0] = (elves[0] + scores[elves[0]] + 1) % scores.size
	elves[1] = (elves[1] + scores[elves[1]] + 1) % scores.size
end



