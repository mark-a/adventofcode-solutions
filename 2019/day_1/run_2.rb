def fuel_formular(mass)
 ((mass / 3.0).floor - 2.0).to_i
end

def recursive_fuel(mass)
  value = fuel_formular mass
  unless value <= 0
    value += recursive_fuel value
  else
    value = 0
  end
  value
end

filename = ARGV.first
txt = open(filename)

sum = 0

txt.read.each_line.with_index do |line,index|
  fuel_req = fuel_formular line.to_f
  fuel_req += recursive_fuel fuel_req
  sum += fuel_req
end

puts sum;

