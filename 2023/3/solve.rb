EXAMPLE_1 = "467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598.."
OUTPUT_1 = 4361

def solve_1(input)
  lines = input.each_line.to_a.map(&:strip)
  numbers = {}

  lines.each_with_index do |line, index|
    matches = line.to_enum(:scan, /\d+/).map { Regexp.last_match }
    matches.each do |match_data|
      numbers[[match_data.begin(0), index]] = match_data.to_s
    end
  end

  numbers.sum do |(x, y), num|
    min_x = [x - 1, 0].max
    min_y = [y - 1, 0].max

    max_x = x + num.length
    max_y = y + 1

    lines[min_y..max_y]
      .map { |row| row[min_x..max_x] }
      .join
      .match?(/[^\d\.]/)
      .then { |matches| matches ? num.to_i : 0 }
  end

end

raise "not yet" unless (solve_1(EXAMPLE_1) == OUTPUT_1)
puts "Part 1: #{solve_1(open("input").read)}"

EXAMPLE_2 = EXAMPLE_1
OUTPUT_2 = 467835

def solve_2(input)
  gears = {}
  numbers = {}

  input.each_line.with_index do |line, y|
    line.to_enum(:scan, /\d+/).map do |_match|
      gears[[Regexp.last_match.begin(0), y]] = []
    end

    line.to_enum(:scan, /\d+/).map do |match|
      numbers[[Regexp.last_match.begin(0), y]] = match.to_s
    end
  end

  numbers.each { |(x, y), num|
    min_x = x - 1
    min_y = y - 1

    max_x = x + num.length
    max_y = y + 1

    (min_x..max_x).to_a.product((min_y..max_y).to_a)
                  .select { gears[_1] }
                  .each { gears[_1] << num.to_i }
  }

  gears
    .values
    .select { _1.count == 2 }
    .sum { _1.reduce(:*) }
end

raise "not yet" unless (solve_2(EXAMPLE_2) == OUTPUT_2)
puts "Part 2: #{solve_2(open("input").read)}"
