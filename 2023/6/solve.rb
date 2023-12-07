EXAMPLE_1 = "Time:      7  15   30
Distance:  9  40  200"
OUTPUT_1 = 288

def number_of_winning_pressing_durations(time, record)
  # hold at least (record / time) ms to win and try all lengths upwards
  min = record / time
  while (((time - min) * min) <= record)
    min += 1
  end

  # hold maximum time and check all lengths downwards
  max = time
  while (((time - max) * max) <= record)
    max -= 1
  end

  # number of solutions = size of continuous space between
  # upper winning press length and minimal winning press length
  max - min + 1
end

def solve_1(input)
  times, times_to_beat = input.each_line
                              .map { |line| line.scan(/\d+/).map(&:to_i) }

  times.zip(times_to_beat).map { |time, to_beat| number_of_winning_pressing_durations(time, to_beat) }.reduce(:*)
end

raise "not yet" unless (solve_1(EXAMPLE_1) == OUTPUT_1)
puts "Part 1: #{solve_1(open("input").read)}"

EXAMPLE_2 = EXAMPLE_1
OUTPUT_2 = 71503

def solve_2(input)
  time, to_beat = input.each_line
                       .map { |line| line.split(":")[1].gsub(/[[:space:]]/, '') }
                       .map(&:to_i)
  number_of_winning_pressing_durations(time, to_beat)
end

raise "not yet" unless (solve_2(EXAMPLE_2) == OUTPUT_2)
puts "Part 2: #{solve_2(open("input").read)}"
