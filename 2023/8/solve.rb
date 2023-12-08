EXAMPLE_1 = "RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)"
OUTPUT_1 = 2

def count_steps_to_z(lookup, steps, start = "AAA", z = /ZZZ/)
  n = 0
  pin = start

  until pin.match? z
    step = steps[n % (steps.length)]

    dir = step == "L" ? 0 : 1
    pin = lookup[pin][dir]

    n += 1
  end
  n
end

def solve_1(input)
  directions, nodes = input.split("\n\n")

  steps = directions.chars

  lookup = {}

  nodes.each_line do |line|
    from, left, right = line.scan /[A-Z]+/
    lookup[from] = [left, right]
  end

  count_steps_to_z(lookup, steps)
end

raise "not yet" unless (solve_1(EXAMPLE_1) == OUTPUT_1)
puts "Part 1: #{solve_1(open("input").read)}"

EXAMPLE_2 = "LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)"
OUTPUT_2 = 6

def solve_2(input)
  directions, nodes = input.split("\n\n")

  steps = directions.chars

  lookup = {}

  nodes.each_line do |line|
    from, left, right = line.scan /[1-9A-Z]+/
    lookup[from] = [left, right]
  end

  starts = lookup.keys.select { |key| key[2] == "A" }

  finishes = starts.map { |start| count_steps_to_z(lookup, steps, start, /Z$/) }
  finishes.reduce(1) { |product, i| product.lcm(i) }
end

raise "not yet" unless (solve_2(EXAMPLE_2) == OUTPUT_2)
puts "Part 2: #{solve_2(open("input").read)}"
