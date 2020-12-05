class Device
  attr_reader :registers

  def initialize(initial)
    @registers = initial
  end
  
  def addr(a, b, c) 
    @registers[c] = @registers[a] + @registers[b]
  end
  
  def addi(a, b, c)
    @registers[c] = @registers[a] + b 
  end

  def mulr(a, b, c)
    @registers[c] = @registers[a] * @registers[b] 
  end

  def muli(a, b, c)
    @registers[c] = @registers[a] * b 
  end

  def banr(a, b, c)
    @registers[c] = @registers[a] & @registers[b] 
  end

  def bani(a, b, c)
    @registers[c] = @registers[a] & b 
  end

  def borr(a, b, c)
    @registers[c] = @registers[a] | @registers[b] 
  end

  def bori(a, b, c)
    @registers[c] = @registers[a] | b 
  end

  def setr(a, _, c)
    @registers[c] = @registers[a] 
  end

  def seti(a, _, c)
    @registers[c] = a 
  end

  def gtir(a, b, c)
    @registers[c] = a > @registers[b] ? 1 : 0 
  end

  def gtri(a, b, c)
    @registers[c] = @registers[a] > b ? 1 : 0 
  end

  def gtrr(a, b, c)
    @registers[c] = @registers[a] > @registers[b] ? 1 : 0 
  end

  def eqir(a, b, c)
    @registers[c] = a == @registers[b] ? 1 : 0 
  end

  def eqri(a, b, c)
    @registers[c] = @registers[a] == b ? 1 : 0 
  end

  def eqrr(a, b, c)
    @registers[c] = @registers[a] == @registers[b] ? 1 : 0 
  end
end

filename = ARGV.first
txt = open(filename).read
samples = txt.split("\n\n")

methods = Device.new([0]).public_methods(false)
methods -= [:registers]
counter = 0

instru_map = {}
methods.size.times do |m|
  instru_map[m] = []
end

samples.each do |sample|
  lines = sample.split("\n")
  before = nil
  after = nil
  instruction = nil
  lines.each do |line|
    if line =~ /Before: /
     before = line.split('[').last.chomp(']').split(', ').map(&:to_i)
    elsif line =~ /After: /
      after = line.split('[').last.chomp(']').split(', ').map(&:to_i)
    else
      instruction = line.chomp.split(' ').map(&:to_i)
    end
  end
  if before && after && instruction
    matches = []
    methods.each do |method|
      device = Device.new before.dup
      device.send method,instruction[1],instruction[2],instruction[3]
      if device.registers == after
        matches.push method
      end
    end
    if matches.size > 0
      instru_map[instruction[0]].push
      matches unless instru_map[instruction[0]].include? matches
    end
  end
end

puts instru_map.inspect

puts counter