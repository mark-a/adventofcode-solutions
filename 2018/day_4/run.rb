filename = ARGV.first
txt = open(filename)

lines = txt.read.each_line.sort

guards = {}

current_guard = nil
sleeping_since = nil

lines.each { |line|
  minute = line.scan(/\d+\]/).first.to_i
  if line =~ /begins shift/
    current_guard = line.scan(/Guard #\d+/).first.scan(/\d+/).first.to_i
  elsif line =~ /falls asleep/
    sleeping_since = minute
  elsif line =~ /wakes up/
    woke_at = minute
    guards[current_guard] = Array.new(60){0} unless guards[current_guard]
    (sleeping_since...woke_at).each { |min| guards[current_guard][min] += 1 }
  end
}

id, minutes = guards.max_by { |_, v| v.sum}
puts "Most asleep: #{id * minutes.each_with_index.max[1]}"

id, minutes = guards.max_by { |_, v| v.max}
puts "Most frequend minute: #{id * minutes.each_with_index.max[1]}"

