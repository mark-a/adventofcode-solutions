EXAMPLE = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"

OUTPUT_1 = 13

def solve(input)
  points = 0
  input.each_line do |line|
    _id, rest = line.split(":")
    winning, own = rest.split("|").map { |numbers| numbers.split.map(&:to_i) }
    worth = 0
    own.each do |number|
      if winning.include? number
        if worth == 0
          worth = 1
        else
          worth *= 2
        end
      end
    end
    points += worth
  end

  points
end

raise "not yet" unless (solve(EXAMPLE) == OUTPUT_1)

puts "Part 1: #{solve(open("input").read)}"

OUTPUT_2 = 30

def solve_2(input)

  cards = {}
  solved_stack = []
  input.each_line do |line|
    identifier, rest = line.split(":")
    id = identifier.split("Card ")[1].to_i
    winning, own = rest.split("|").map { |numbers| numbers.split.map(&:to_i) }
    cards[id] = [winning, own]
    solved_stack.push [id, [winning, own]]
  end


  pin = 0

  while pin < solved_stack.count do
    id, work = solved_stack[pin]
    winning, own = work

    win_count = 0
    own.each do |number|
      if winning.include? number
        win_count += 1
      end
    end

    if win_count > 0
      (1..win_count).each do |x|
        solved_stack.push [id+x,cards[id+x]]
      end
    end


    pin += 1
  end

  solved_stack.count
end

raise "not yet" unless (solve_2(EXAMPLE) == OUTPUT_2)

puts "Part 2: #{solve_2(open("input").read)}"
