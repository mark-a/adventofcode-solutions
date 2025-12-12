input = open("input").read

parts = input.split("\n\n")

definitions = parts[..5].map do |box_def|
  map = box_def.lines[1..].map(&:strip).map { |line| line.chars.map { |c| c == "#" } }
  [map.flatten.count(true), map]
end

regions = parts.last.lines.map do |line|
  line_parts = line.split(" ")
  width, height = line_parts[0].gsub(":", "").split("x").map(&:to_i)
  counts = line_parts[1..].map(&:to_i)
  [[width, height], counts]
end

#puts definitions.inspect
#puts regions.inspect

naive_fit_count  = regions.count do |region|
  dimensions, counts = region

  total_area_needed = counts.map.with_index do |needed, index|
    needed * definitions[index].first
  end.sum

  # puts "#{ dimensions.inject(:*)} > #{total_area_needed} ?"

  dimensions.inject(:*) > total_area_needed
end


puts "Part 1: #{naive_fit_count}"