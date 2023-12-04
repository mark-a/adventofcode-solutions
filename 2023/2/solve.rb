EXAMPLE_1 = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"

OUTPUT_1 = 8

def solve_1(input)
  constraints = {
    red: 12,
    green: 13,
    blue: 14
  }

  output = 0
  input.each_line do |line|
    ident, rest = line.split(":")
    id = ident.split("Game ")[1].to_i

    reds = rest.scan(/(\d+) red/).flatten
    greens = rest.scan(/(\d+) green/).flatten
    blues =  rest.scan(/(\d+) blue/).flatten

    if reds.any? && reds.all?{|x| x.to_i <= constraints[:red]} &&
      greens.any? && greens.all?{|x| x.to_i <= constraints[:green]} &&
      blues.any? && blues.all?{|x| x.to_i <= constraints[:blue]}

      output += id
    end
  end

  output
end

raise "not yet" unless (solve_1(EXAMPLE_1) == OUTPUT_1)
puts "Part 1: #{solve_1(open("input").read)}"

EXAMPLE_2 = EXAMPLE_1
OUTPUT_2 = 2286

def solve_2(input)
  output = 0

  input.each_line do |line|
    _ident, rest = line.split(":")

    reds = rest.scan(/(\d+) red/).flatten
    greens = rest.scan(/(\d+) green/).flatten
    blues =  rest.scan(/(\d+) blue/).flatten

    min_reds = 0
    if reds.any?
      min_reds = reds.map(&:to_i).max
    end

    min_greens = 0
    if greens.any?
      min_greens = greens.map(&:to_i).max
    end

    min_blues = 0
    if blues.any?
      min_blues = blues.map(&:to_i).max
    end

    output += min_reds * min_greens * min_blues
  end

  output
end

raise "not yet" unless (solve_2(EXAMPLE_2) == OUTPUT_2)
puts "Part 2: #{solve_2(open("input").read)}"
