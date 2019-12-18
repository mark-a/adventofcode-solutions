require_relative '../shared/intcode'

filename = ARGV.first
txt = open(filename)

input = txt.read.strip.split(",").map(&:to_i)

def chain(mem, phases)
  amps = phases.map { |phase|
    Intcode.new(mem).process(phase)
  }

  output = [0]
  amps.each_with_index.cycle { |amp, id|
    return output if amp.halted?
    output = amp.process(output).output
  }
end

range = (0..4)
h = {}
range.to_a.permutation { |phases|
h[phases] = chain(input, phases).then { |xs|
  xs[0]
}
}
puts h.values.max
