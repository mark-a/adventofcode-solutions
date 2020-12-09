filename = ARGV.first
txt = open(filename)
input = txt.read.strip

short = input.chars.map(&:to_i)
long =  (short * 10_000)
offset = input[0, 7].to_i
work = long[offset..long.size]
max = work.size

100.times do
  (max - 2).downto(0) do |i|
    work[i] = (work[i] + work[i + 1]) % 10
  end
end
puts work.first(8).join