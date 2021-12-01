input =  open("input_13").map(&:chomp)

Bus = Struct.new(:id, :departure)

start_time = input[0].to_i
buses = input[1].split(/,/).filter_map do |bus_id|
  Bus.new(bus_id.to_i, bus_id.to_i) unless bus_id == 'x'
end

while true
  behind_schedule = buses.reject { |bus| bus.departure >= start_time }

  break if behind_schedule.empty?

  behind_schedule.map { |bus| bus.departure += bus.id }
end

first_bus = buses.min_by(&:departure)
puts "Solution 1: #{(first_bus.departure - start_time) * first_bus.id}"




departure_offsets = []

input[1].split(/,/).filter_map.with_index do |bus_id, index|
  departure_offsets << index * -1 unless bus_id == 'x'
end


# Source: https://rosettacode.org/wiki/Chinese_remainder_theorem#Ruby
module ChineseRemainder
  extend self

  def solve(mods, remainders)
    max = mods.inject( :* )  # product of all moduli
    series = remainders.zip(mods).map{ |r,m| (r * max * invmod(max/m, m) / m) }
    series.inject( :+ ) % max
  end

  def extended_gcd(a, b)
    last_remainder, remainder = a.abs, b.abs
    x, last_x, y, last_y = 0, 1, 1, 0
    while remainder != 0
      last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
      x, last_x = last_x - quotient*x, x
      y, last_y = last_y - quotient*y, y
    end
    return last_remainder, last_x * (a < 0 ? -1 : 1)
  end

  def invmod(e, et)
    g, x = extended_gcd(e, et)
    if g != 1
      raise 'Multiplicative inverse modulo does not exist!'
    end
    x % et
  end
end

p ChineseRemainder.solve(buses.map(&:id), departure_offsets) # => 780601154795940