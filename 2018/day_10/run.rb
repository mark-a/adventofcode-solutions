filename = ARGV.first
txt = open(filename)

class Light
	attr_accessor :x,:y,:d_x,:d_y,:ticks
	
	def initialize(x,y,d_x,d_y)
		@x = x
		@y = y 
		@d_x = d_x
		@d_y = d_y
		@ticks = 0
	end
	
	def tick
		@x += @d_x
		@y += @d_y
		@ticks += 1
	end
end

lights = []
txt.read.each_line do |line|
	numbers = line.scan(/-?\d+/)
	lights.push Light.new(*numbers.map(&:to_i))
end

def distance(lights)
	max_frame = frame(lights)
	x_vals = [max_frame[0][0],max_frame[1][0]]
	y_vals = [max_frame[0][1],max_frame[1][1]]
	[x_vals.max - x_vals.min , y_vals.max - y_vals.min]
end

def frame(lights)
	x_vals = lights.map(&:x).minmax
	y_vals = lights.map(&:y).minmax
	[[x_vals[0],y_vals[0]],[x_vals[1],y_vals[1]]]
end

last = distance(lights)

loop do
	lights.each(&:tick)
	new = distance(lights)
	if new[1] < 20
		picture = frame(lights)
		puts
		(picture[0][1]..picture[1][1]).each do |y|
			line = ""
				(picture[0][0]..picture[1][0]).each do |x|
					on_position =  lights.select{|light| light.x == x && light.y == y}.any?
					line += on_position ? "X" : "."
				end
				puts line
			end
		puts lights.last.ticks
	end
	
	if new[1] >= last[1] 
		break
	else
		last = new
	end
end


