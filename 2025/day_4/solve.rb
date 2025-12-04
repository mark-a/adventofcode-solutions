def access_count(grid,with_remove: false)
  access_count = 0
  grid.each_with_index do |row, row_index|
    row.each_with_index do |value, column_index|
      if value == "@"
        roll_count = 0
        [-1, 0, 1].each do |row_check|
          [-1, 0, 1].each do |column_check|
            next if row_check == 0 && column_check == 0
            r = row_index + row_check
            c = column_index + column_check
            next if r < 0 || c < 0
            next if r >= grid.size || c >= row.size

            roll_count += 1 if grid[r][c] == "@"
          end
        end
        if roll_count < 4
          access_count += 1
          grid[row_index][column_index] = "." if with_remove
        end
      end
    end
  end
  access_count
end

input = open("input").read

grid = []
input.each_line do |line|
  grid.push line.strip.split('')
end

puts "Part 1: #{access_count(grid)}"


counter = 0
while (new_value = access_count(grid, with_remove: true)) > 0
  counter += new_value
end

puts "Part 2: #{counter}"