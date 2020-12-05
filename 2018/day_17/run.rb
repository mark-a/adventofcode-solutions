require 'set'

class Reservoir
  attr_reader :ymin, :ymax

  def initialize(clay)
    @clay = clay.freeze
    @clay.each_value(&:freeze) if @clay.is_a?(Hash)
    @water_at_rest = Hash.new { |h, k| h[k] = Set.new }
    @water_flow = Hash.new { |h, k| h[k] = Set.new }
    @ymin, @ymax = clay.each_key.minmax
  end

  def fill_down(srcy:, srcx:)
    done_drops = {}
    checked_fill_down(srcy: srcy, srcx: srcx, done: done_drops)
  end

  def water_size
    water_at_rest = 0
    water_reach = 0
    (@ymin..@ymax).sum { |y|
      at_rest = @water_at_rest[y]
      water_reach += (at_rest | @water_flow[y]).size
      water_at_rest += at_rest.size
    }
    [water_reach, water_at_rest]
  end

  def to_s(yrange: (@ymin..@ymax), xrange: nil)
    xrange ||= begin
      # Yuck, Enumerable#chain in Ruby 2.6.0  maybe?
      xs = @water_flow.each_value.reduce(@water_at_rest.each_value.reduce(Set.new, :|), :|)
      xmin, xmax = xs.minmax
      # Margin of 1 so we can see the limiting walls too.
      ((xmin - 1)..(xmax + 1))
    end

    yrange.map { |y|
      xrange.map { |x|
        flow = @water_flow[y].include?(x) ? ?| : nil
        rest = @water_at_rest[y].include?(x) ? ?~ : nil
        clay = @clay.dig(y, x) ? ?# : nil
        chars = [clay, rest, flow].compact
        raise "#{y}, #{x} conflicts: #{chars}" if clay && (flow || rest)

        chars.first || ' '
      }.join
    }.join("\n")
  end

  private

  def checked_fill_down(srcy:, srcx:, done:)
    return if done[[srcy, srcx]]
    done[[srcy, srcx]] = true

    lowest_reachable = (srcy..@ymax).find { |y|
      @clay.dig(y, srcx) || @water_at_rest[y].include?(srcx)
    }

    unless lowest_reachable
      # Fall off the bottom of the screen
      (srcy..@ymax).each { |y|
        @water_flow[y] << srcx
      }
      return
    end

    lowest_reachable -= 1
    (srcy..lowest_reachable).each { |y|
      @water_flow[y] << srcx
    }

    lowest_reachable.step(by: -1) { |current|
      left_type, leftx   = scout(srcy: current, srcx: srcx, dir: -1)
      right_type, rightx = scout(srcy: current, srcx: srcx, dir: 1)

      walled = left_type == :wall && right_type == :wall

      if left_type == :wall && right_type == :wall
        water_type = @water_at_rest
      else
        water_type = @water_flow
        puts [
          "Water falls from #{srcy} #{srcx} to #{lowest_reachable}",
          "filled up to #{current}",
          "left[#{left_type}@#{leftx}]",
          "right[#{right_type}@#{rightx}]",
        ].join(', ') if VERBOSE
        checked_fill_down(srcy: current, srcx: leftx,  done: done) if left_type == :drop
        checked_fill_down(srcy: current, srcx: rightx, done: done) if right_type == :drop
      end

      ((leftx + 1)...rightx).each { |x|
        water_type[current] << x
      }

      break unless walled
    }
  end

  def scout(srcy:, srcx:, dir:)
    (srcx + dir).step(by: dir) { |x|
      if !@clay.dig(srcy + 1, x) && !@water_at_rest[srcy + 1].include?(x)
        return [:drop, x]
      elsif @clay.dig(srcy, x)
        return [:wall, x]
      end
    }
  end
end

SPRING = 500
VERBOSE = true
xauto = true

filename = ARGV.first
txt = open(filename)

txt.read.each_line do |line| 
  l, r = line.scan(/\d+/).map(&:to_i)
  # If it's two numbers, assume it's left/right.
  # If it's one number, assume it's margin around the spring.
  r ? l..r : (SPRING - l)..(SPRING + l)
end

TESTDATA = <<TEST.freeze
x=495, y=2..7
y=7, x=495..501
x=501, y=3..7
x=498, y=2..4
x=506, y=1..2
x=498, y=10..13
x=504, y=10..13
y=13, x=498..504
TEST

# No default_proc because I'm freezing it.
clay = {}

(ARGV.include?('-t') ? TESTDATA : ARGV.empty? ? DATA : ARGF).each_line.map { |line|
  names = line.split(', ').map { |elt|
    name, spec = elt.split(?=)
    spec = if spec.include?('..')
      l, r = spec.split('..')
      l.to_i..r.to_i
    else
      spec.to_i..spec.to_i
    end
    [name, spec]
  }.to_h

  names[?y].each { |y|
    clay[y] ||= {}
    names[?x].each { |x|
      clay[y][x] = true
    }
  }
}

reservoir = Reservoir.new(clay)
reservoir.fill_down(srcy: 0, srcx: SPRING)
puts reservoir.water_size

