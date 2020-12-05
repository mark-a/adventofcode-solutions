filename = ARGV.first
txt = open(filename)

MOONS = []

Moon = Struct.new(:position,:velocity)
txt.each_line.map do |line|
    MOONS.push Moon.new(
        line.scan(/-?\d+/).map(&:to_i),
        [0,0,0]
    )
end 


def step()

    MOONS.combination(2).each do |first,second|
        (0..2).each do |i|
            first.velocity[i] +=  second.position[i] <=> first.position[i]
            second.velocity[i] += first.position[i] <=> second.position[i]
        end
    end

    MOONS.each do |moon|
        moon.velocity.each_with_index do |vel, i| 
            moon.position[i] += vel 
        end
    end
end

1000.times { step() }

puts MOONS.sum { |moon| moon.position.sum(&:abs) * moon.velocity.sum(&:abs) }
