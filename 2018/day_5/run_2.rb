filename = ARGV.first
txt = open(filename)

poly = txt.read.chomp

def react(chain)
   new_string = ""
   chain.each_char do |current|
     new_string+=current
	 new_string = new_string[0...-2] if new_string[-2]&.swapcase == current
   end
   new_string
end

current_lowest = poly.size
('a'..'z').each do |char_to_strip|
	local = poly.dup.delete(char_to_strip).delete(char_to_strip.upcase)
	loop do
		old_size = local.size
		local = react(local)
		new_size = local.size
		if old_size == new_size
			break;
		end
	end
	if local.size < current_lowest
		current_lowest = local.size
	end
end

puts current_lowest


