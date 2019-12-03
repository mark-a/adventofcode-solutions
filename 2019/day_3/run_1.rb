filename = ARGV.first
txt = open(filename)


GRID = {}

def add(pos,index)
  position = pos.clone
  if GRID[position] 
    if !GRID[position].include? index 
       GRID[position].push index 
    end
  else
      GRID[position] = [index]
  end
end

txt.read.each_line.with_index do |line,index|
  moves = line.strip().split(",")
  position = [0,0]
  moves.each do |move|
    direction = move[0]
    run_length = move[1..-1].to_i
    case direction
    when "D"
      run_length.times do
        position[1] -= 1
        add(position, index)
      end
    when "L"
      run_length.times do
        position[0] -= 1
        add(position, index)
      end
    when "R"
      run_length.times do
        position[0] += 1
        add(position, index)
      end
    when "U"
      run_length.times do
        position[1] += 1
        add(position, index)
      end
    else
     raise Error
    end
  end
end

GRID.select{|_,value| value.size == 2}.sort_by{|key,_| key[0].abs + key[1].abs }.each do |key, vaue|
  puts "crossing at: #{key.inspect} (dist: #{key[0].abs + key[1].abs })"
end



