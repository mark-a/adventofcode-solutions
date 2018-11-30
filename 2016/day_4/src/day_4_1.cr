path = ARGV.first
content = File.read path
id_sum = 0
content.each_line do |line|
	parts = line.split('[')
	code = parts[0]
	checksum = parts[1].rstrip(']')
	reader = Char::Reader.new(code)
	charmap = {} of Char => Int32
	id_parts = [] of Char
	reader.each do |c|
	  if c == '-'
	    next
	  elsif c.number?
	    id_parts.push c
	  else
	    value = charmap.fetch(c,0) + 1
	    charmap[c] = value
	  end
	end
	sorted = charmap.to_a.sort { |entry,other_entry| 
		if other_entry[1] < entry[1]
		    -1
		elsif other_entry[1] > entry[1]
		   1
		else
		   entry[0] <=> other_entry[0]
		end
	}
	if sorted.shift(5).map(&.first).join() ==  checksum
	  id_sum += id_parts.join.to_i
	end
end
puts id_sum
