input = 430971

elves = [0,1]
scores = [3, 7]
counter = 0
loop do
	new_recipe = scores[elves[0]] + scores[elves[1]]
	new_recipe.digits.reverse.each do |digit|
		scores.push digit 
	end
	elves[0] = (elves[0] + scores[elves[0]] + 1) % scores.size
	elves[1] = (elves[1] + scores[elves[1]] + 1) % scores.size
	if counter ==  input + 10
		puts scores[input,10].join
		break;
	end
	counter+= 1
end



