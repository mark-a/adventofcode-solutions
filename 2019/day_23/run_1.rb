require_relative '../shared/intcode'

filename = ARGV.first
txt = open(filename)

input = txt.read.split(",").map(&:to_i)

ics = (0..49).map { |x| {id: x, ic: Intcode.new(input).process(x), q: []} }
last_to_nat = nil
last_y_sent_by_nat = nil

loop {
  ics.each { |icq|
    ic = icq[:ic]
    ic.process(icq[:q].empty? ? -1 : icq[:q].shift)

    raise "expected output in threes not #{ic.output}" if ic.output.size % 3 != 0

    ic.output.each_slice(3) { |addr, x, y|
      if addr == 255
        if last_to_nat.nil?
			puts y 
			return 0;
		end
        last_to_nat = [x, y].freeze
      else
        ics[addr][:q] << [x, y]
      end
    }
    ic.output.clear
  }
}