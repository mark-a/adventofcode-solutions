path = ARGV.first
content = File.read path
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
	sector_id = id_parts.join.to_i
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
	    decrypted = [] of Char
	    shift_by = sector_id % 26
	    reader = Char::Reader.new(code)
	    reader.each do |c|
	      if c == '-'
	      	decrypted.push ' '
	      elsif c.number?
	        break
	      else
		n = c + shift_by
		if n > 'z'
		  n -= 26
		end
		decrypted.push n
	      end
	    end
	    name = decrypted.join
	    puts "#{name} in sector: #{sector_id}" if name =~ /object storage/
	end
end
