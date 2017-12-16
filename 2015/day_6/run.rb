filename = ARGV.first
txt = open(filename)

grid = Array.new(1000) {Array.new(1000,false)}
brightness_grid = Array.new(1000) {Array.new(1000,0)}
inst_regex = /(?<verb>.*) (?<from_x>\d+),(?<from_y>\d+) through (?<to_x>\d+),(?<to_y>\d+)/

txt.read.each_line do |line|
    instruction = line.match(inst_regex)
    (instruction[:from_x].to_i..instruction[:to_x].to_i).each do |x|
        (instruction[:from_y].to_i..instruction[:to_y].to_i).each do |y|
            case instruction[:verb]
                when "turn on" then
                    grid[x][y] = true
                    brightness_grid[x][y] += 1
                when "turn off" then
                    grid[x][y] = false
                    if brightness_grid[x][y] > 0
                        brightness_grid[x][y] -= 1
                    end
                when "toggle" then
                    grid[x][y] = !grid[x][y]
                    brightness_grid[x][y] += 2
            end
        end
    end
end

count = 0
total_brightness = 0
(0..999).each do |x|
    count += grid[x].count { |light| !!light }
    total_brightness +=  brightness_grid[x].sum
end

puts count
puts total_brightness



