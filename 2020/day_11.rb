input = open('input_11').map { |l| l.chars }

map = input.dup
any_changed = true
while any_changed
  any_changed = false
  map = map.map.with_index do |line, y|
    line.map.with_index do |c, x|
      possible = [ [y+1,x], [y-1,x], [y,x+1], [y,x-1], [y+1,x+1], [y+1,x-1], [y-1,x-1], [y-1,x+1] ]
      occupied = possible.count { |cy,cx| cy >= 0 && cy < map.size && cx >= 0 && cx < line.size && map[cy][cx] == '#' }

      if c == 'L' && occupied == 0; any_changed = true; '#'
      elsif c == '#' && occupied >= 4; any_changed = true; 'L'
      else; c; end
    end
  end
end
puts map.map { |l| l.count('#') }.sum


map = input.dup
possible = [ [1,0], [-1,0], [0,1], [0,-1], [1,1], [1,-1], [-1,-1], [-1,1] ]
visible_seats = {}
map.each_with_index do |line, y|
  line.each_with_index do |c, x|
    visible = []
    possible.each do |dy,dx|
      idx = 1
      while true
        cy, cx = [y + idx * dy, x + idx * dx]
        break if cy < 0 || cy >= map.size || cx < 0 || cx >= line.size
        visible.push([cy,cx]) && break if map[cy][cx] == 'L'
        idx += 1
      end
    end
    visible_seats[[y,x]] = visible
  end
end

any_changed = true
while any_changed
  any_changed = false
  map = map.map.with_index do |line, y|
    line.map.with_index do |c, x|
      occupied = visible_seats[[y,x]].map { |y,x| map[y][x] == '#' ? 1 : 0 }.sum

      if c == 'L' && occupied == 0; any_changed = true; '#'
      elsif c == '#' && occupied >= 5; any_changed = true; 'L'
      else; c; end
    end
  end
end
puts map.map { |l| l.count('#') }.sum