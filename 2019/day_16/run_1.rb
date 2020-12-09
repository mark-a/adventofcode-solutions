filename = ARGV.first
txt = open(filename)

input = txt.read.strip.chars.map(&:to_i)
max = input.size
pattern = [0, 1, 0, -1]

100.times do
  (1..max).map do |current|
    value = (current..max).reduce(0) do |sum, n|
      sum + input[n - 1] * pattern[(n / current) % 4]
    end
    input[current - 1] = value.abs % 10
  end
end

puts input.first(8).join