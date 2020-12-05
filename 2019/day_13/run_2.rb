require_relative '../shared/intcode'
require "tty-prompt"

filename = ARGV.first
txt = open(filename)

input = txt.read.split(",").map(&:to_i)
input[0] = 2
computer = Intcode.new(input)
next_input = []

def tile(code)
  case code
    when 0 then " " # empty
    when 1 then "#" # wall
    when 2 then "X" # block
    when 3 then "=" # paddle
    when 4 then "o" # ball
  end
end

prompt = TTY::Prompt.new
score = 0

screen = Array.new(23).map { Array.new }
until computer.halted?
computer.process next_input
outputs = computer.output
    if outputs
    xb = 0
    xp = 0
    outputs.each_slice(3) do |x, y, t|
        if x == -1 && y == 0
        score = t
        else
        screen[y][x] = tile(t)
        case t
            when 3 then xp = x
            when 4 then xb = x
        end
        end
    end

    term = "\e[H\e[2J"
    term += screen[0].join + "\n"
    term += format("%s %s %s\n", tile(1), score.to_s.center(screen[0].size - 4), tile(1))
    term += screen.each_with_index.reduce("") do |r, (l, i)|
    r + l.join + "\n"
        
    end
    puts term
    end


sleep 0.001
next_input = xb <=> xp

end
