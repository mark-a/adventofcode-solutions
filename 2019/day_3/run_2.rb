filename = ARGV.first
txt = open(filename)


GRID = {}

def add(pos,index,steps)
  position = pos.clone
  if GRID[position] 
    if !GRID[position].include? index 
       GRID[position][index] = steps
    end
  else
      GRID[position] = {}
      GRID[position][index] = steps
  end
end

txt.read.each_line.with_index do |line,index|
  moves = line.strip().split(",")
  position = [0,0]
  step_counter = 0
  moves.each do |move|
    direction = move[0]
    run_length = move[1..-1].to_i
    case direction
    when "D"
      run_length.times do
        step_counter+= 1
        position[1] -= 1
        add(position, index, step_counter)
      end
    when "L"
      run_length.times do
        step_counter+= 1
        position[0] -= 1
        add(position, index, step_counter)
      end
    when "R"
      run_length.times do
        step_counter+= 1
        position[0] += 1
        add(position, index, step_counter)
      end
    when "U"
      run_length.times do
        step_counter+= 1
        position[1] += 1
        add(position, index, step_counter)
      end
    else
     raise Error
    end
  end
end

GRID.select{|_,value| value.keys.size == 2}.sort_by{|_,value| value.values.sum }.each do |key, value|
  puts "crossing at: #{key.inspect} (steps: #{ value.values.sum  })"
end



