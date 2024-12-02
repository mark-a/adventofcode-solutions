require "json"

a_json = JSON.parse(File.read("input"))

def nested_hash_value(obj)
  value = 0
  if obj.kind_of?(Integer)
    value += obj
  else
    if obj.respond_to?(:each)
      obj.each do |sub_obj|
        value += nested_hash_value(sub_obj)
      end
    end
  end
  value
end

puts "Part 1: #{nested_hash_value(a_json)}"

def nested_hash_value_without_red(obj)
  value = 0
  if obj.respond_to?(:values) && obj.to_a.map(&:last).include?("red")
    return 0
  end
  if obj.kind_of?(Integer)
    value += obj
  else
    if obj.respond_to?(:each)
      obj.each do |sub_obj|
        value += nested_hash_value_without_red(sub_obj)
      end
    end
  end
  value
end

puts "Part 2: #{nested_hash_value_without_red(a_json)}"