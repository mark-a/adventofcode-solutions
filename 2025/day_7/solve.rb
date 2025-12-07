input = open("input").read

streams = []
split_counter = 0
input.each_line.with_index do |line, line_index|
    if line_index == 0
        streams = Array.new(line.size){false}
        streams[line.chars.find_index('S')] = true        
    else
        line.chars.each_with_index do |char, index|
            if char == "^" && streams[index]
                split_counter += 1
                streams[index] = false
                streams[index + 1] = true if (index + 1) < streams.size
                streams[index - 1] = true if (index - 1) >= 0
            end
        end
    end
end

puts "Part 1: #{split_counter}"

streams = []
input.each_line.with_index do |line, line_index|
    if line_index == 0
        streams = Array.new(line.size){0}
        streams[line.chars.find_index('S')] = 1
    else
        line.chars.each_with_index do |char, index|
            if char == "^" && streams[index] > 0                
                streams[index + 1] +=  streams[index] if (index + 1) < streams.size
                streams[index - 1] +=  streams[index] if (index - 1) >= 0
                streams[index] = 0
            end
        end
    end
end

puts "Part 2: #{streams.sum()}"
