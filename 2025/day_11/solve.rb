input = open("input").read

nodes = {}
input.each_line do |line|
  key, rest = line.split(":")
  targets = rest.strip.split(" ").map(&:to_sym)
  nodes[key.to_sym] = Set[*targets]
end

def count_paths(nodes, from:, to:)
  count = 0
  working = [[from, Set[]]]
  while working.size > 0 do
    current, path = working.pop
    if current == to
      count += 1
    else
      next unless nodes.key? current
      nodes[current].each do |check|
        unless path.include? check
          working.push [check, [ path  + [check]]]
        end
      end
    end
  end
  count
end

puts "Part 1: #{count_paths(nodes, from: :you, to: :out)}"

def count_paths_recursive(nodes, node, requirements = Set[] , cache ={})
  return { Set[] => 1 } if node == :out
  return cache[node] if cache[node]

  child_counts = nodes[node]
                   .map { |n| count_paths_recursive(nodes, n, requirements, cache) }
                   .reduce do |counts, subcounts|
    counts.merge(subcounts) { |_set_key, count_left, count_right| count_left + count_right }
  end

  if requirements.include? node
    child_counts = child_counts.to_h { |k,v| [k + [node], v]}
  end

  cache[node] = child_counts
end

needed = Set[:fft, :dac]
counts =  count_paths_recursive(nodes,:svr, needed)[needed]

puts "Part 2: #{counts}"
