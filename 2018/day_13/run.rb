filename = ARGV.first
txt = open(filename)
map = txt.each_line.map(&:chomp)

DIRECTIONS = {
  '<': [0, -1],
  '>': [0, 1],
  '^': [-1, 0],
  'v': [1, 0]
}

class Cart 
  attr_accessor :position, :direction, :intersections, :alive
  
  def initialize(position, direction)
	@alive = true
	@position = position
	@direction = direction
  end
  
  
	def falling_curve((y, x))
	  [x, y]
	end

	def rising_curve((y, x))
	  [-x, -y]
	end

	def turn_left((y, x))
	  [-x, y]
	end

	def turn_right((y, x))
	  [x, -y]
	end

	def turn_intersection(dir, times)
	  case times % 3
	  when 1; turn_left(dir)
	  when 2; dir
	  when 0; turn_right(dir)
	  end
	end
  
  
  def move!
    @position = @position.zip(dir).map(&:sum)
  end
end

carts = map.each_with_index.map { |row, y|
  row.each_char.with_index.map { |c, x|
    if (dir = DIRECTIONS[c.to_sym])
      Cart.new([y, x], dir)
    end
  }.compact
}


first_crash = true

occupied = carts.map { |cart| [cart.position, cart] }.to_h

until carts.size <= 1

  carts.each { |cart|
    next unless cart.alive

    occupied.delete(cart.position)

    if (crashed = occupied.delete(cart.move!))
      if first_crash
        puts cart.pos.reverse.join(',')
        first_crash = false
      end
      cart.dead = true
      crashed.dead = true
      next
    end

    occupied[cart.position] = cart

    
	case map[cart.position[0]][cart.position[1]]
		when '\\'
			cart.direction = falling_curve(cart.direction)
		when '/' 
			cart.direction = rising_curve(cart.direction)
		when '+' 
			cart.direction = turn_intersection(cart.direction, cart.intersections += 1)
		else 
			cart.direction = cart.direction
    end
  }

  carts.reject!(&:dead)
end

puts carts[0].position.reverse.join(',') unless carts.empty?