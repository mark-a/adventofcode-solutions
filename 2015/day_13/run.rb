rules = {}

File.readlines("input").each do |rule|
  person, qualifier, h_units, neighbor = rule.scan(/(.*) would (lose|gain) (\d+) happiness units by sitting next to (.*)./).first
  if qualifier == "lose"
    happiness = -(h_units.to_i)
  else
    happiness = h_units.to_i
  end

  rules[person] = {} if !rules[person]
  rules[person][neighbor] = happiness
end

happiness_changes = rules.keys.permutation.map do |seating|
  seating = seating.push(seating.first)
  seating.each_cons(2).inject(0) do |total, (person, next_to)|
    total + rules[person][next_to] + rules[next_to][person]
  end
end

puts "Part 1: #{happiness_changes.max}"

rules["me"] = {}
rules.keys.each do |person|
  rules["me"][person] = 0
  rules[person]["me"] = 0
end

happiness_changes = rules.keys.permutation.map do |seating|
  seating = seating.push(seating.first)
  seating.each_cons(2).inject(0) do |total, (person, next_to)|
    total + rules[person][next_to] + rules[next_to][person]
  end
end

puts "Part 2: #{happiness_changes.max}"