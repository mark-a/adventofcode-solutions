def input
  @input ||= open("input_16").read.split("\n\n")
end

def rules
  @rules ||= input[0].split("\n").each_with_object({}) do |line, obj|
    matches = /(.+): (\d+)\-(\d+) or (\d+)\-(\d+)/.match(line)
    obj[matches[1]] = [
      matches[2].to_i..matches[3].to_i,
      matches[4].to_i..matches[5].to_i
    ]
  end
end

def your_ticket
  @your_ticket ||= input[1].
    split("\n").
    last.
    split(",").
    map(&:to_i)
end

def nearby_tickets
  @nearby_tickets ||= input[2].
    split("\n")[1..].
    map { |line| line.split(",").map(&:to_i) }
end

def invalid_for_all_fields?(val)
  rules.all? do |field, ranges|
    ranges.none? { |range| range.cover?(val) }
  end
end

def error_rate
  nearby_tickets.flat_map do |ticket|
    ticket.select(&method(:invalid_for_all_fields?))
  end.sum
end

p error_rate


def valid_tickets
  @valid_tickets ||= nearby_tickets.reject do |ticket|
    ticket.any? { |val| invalid_for_all_fields?(val) }
  end
end

def valid_positions(ranges)
  (0...rules.count).select do |i|
    valid_tickets.all? do |ticket|
      ranges.any? { |range| range.cover?(ticket[i]) }
    end
  end
end

def all_valid_positions
  @all_valid_positions ||= rules.map do |name, ranges|
    [name, valid_positions(ranges)]
  end.sort_by { |_name, positions| positions.count }
end

def valid_ordering
  orderings = all_valid_positions
  orderings.each_with_index.each_with_object({}) do |((field, positions), i), result|
    num = positions.first
    result[field] = num
    orderings.each { |_f, p| p.delete(num) }
  end
end


valid_ordering.
    sort_by(&:last).
    select { |field, _position| field.start_with?("departure") }.
    map(&:last).
    tap { |indices| p your_ticket.values_at(*indices).reduce(:*) }
