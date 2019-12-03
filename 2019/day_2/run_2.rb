filename = ARGV.first
txt = open(filename)

input = []
txt.read.each_line.with_index do |line, index|
  values = line.split(',').reject { |c| c == "\n" }.map(&:to_i)
  input += values
end

(0..99).each do |noun|
  (0..99).each do |verb|
    set = input.map(&:clone)

    set[1] = noun
    set[2] = verb

    index = 0
    while set[index] != 99 do
      if set[index] == 1
        set[set[index + 3]] = set[set[index + 1]] + set[set[index + 2]]
      elsif set[index] == 2
        set[set[index + 3]] = set[set[index + 1]] * set[set[index + 2]]
      else
        raise "Illegal opcode #{ set[index]}"
      end
      index += 4
    end

    answer = set[0]

    if answer == 19690720
      puts 100 * noun + verb
      exit 1
    end
  end
end
	













