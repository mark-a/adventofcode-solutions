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

counter = 0;
loop do
	counter+=1;
	puts "@ iteration #{counter}"
	old_size = poly.size
	poly = react(poly)
	new_size = poly.size
	if old_size == new_size
		break;
	end
end
puts poly.size


