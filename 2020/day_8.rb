PROGRAM = open("input_8").map{ |line| line.chomp.split(' ') }

def run_program(program)
  ip = 0
  acc = 0
  seen = Array.new(program.size) { |i| 0 }
  
  while (0...program.size).include?(ip)
    instr = program[ip][0]
    val = program[ip][1].to_i

    seen[ip] += 1
    break if seen[ip] == 2
    
    case instr
    when 'acc'
      acc += val
      ip += 1
    when 'jmp'
      ip += val
    when 'nop'
      ip += 1
    else    
    end
  end
  
  [ip, acc]
end

# Part 1
_, acc = run_program(PROGRAM)
puts "#{ acc }"

# Part 2
def fixed_program_acc(program)
  program.each_with_index do |instr, idx|
    next if instr[0] == 'acc'
  
    program[idx][0] = instr[0] == 'jmp' ? 'nop' : 'jmp'
    
    ip, acc = run_program(program)
    return acc if ip >= program.size
    
	program[idx][0] = instr[0] == 'jmp' ? 'nop' : 'jmp'
  end
  
  "unfixable"
end
puts "#{ fixed_program_acc(PROGRAM) }"