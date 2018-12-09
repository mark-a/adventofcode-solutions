Circle = Struct.new(:left, :right) do

end

class Game
	attr_accessor :scores, :board

	def left
		if @board[0].empty?
			@board[0] = @board[1]
			@board[1] = []
		end
		@board[1].unshift @board[0].pop
	end

	def right
		if @board[1].empty?
		@board[1] = @board[0]
		@board[0] = []
		end
		@board[0].push @board[1].shift
	end

	def initialize(no_players, last_marble)
		@scores = Array.new(no_players,0)
		@last_marble = last_marble
		@board =[[0],[]]
	end
	
	def outcome
		(1..@last_marble).each do |tick|
			if tick % 23 == 0
				7.times { left }
				@scores[tick % @scores.size] += tick + (@board[0].empty? ? @board[1] : @board[0]).pop
				right
			else
				right
				@board[0].push tick
			end
		end
		@scores.max
	end
end

no_players = 423
last_marble = 71944

puts Game.new(no_players, last_marble).outcome
puts Game.new(no_players, last_marble * 100).outcome
