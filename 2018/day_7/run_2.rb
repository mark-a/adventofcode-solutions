filename = ARGV.first
txt = open(filename)


tree= {}

txt.read.each_line do |line|
 parts = line.split(' must be finished before step ')
 before = parts[0].chars.last
 after = parts[1].chars.first
 tree[before] = {  req: [] } unless tree[before]
 tree[after] = { req: [] } unless tree[after]
 tree[after][:req].push before
end


def take_next!(tree)
	if tree.to_a.select{|key,value| !value[:req].any? }.size > 0
		selection = tree.to_a.select{|key,value| !value[:req].any? }.sort_by{|key,value| key}.first[0]
		current = tree.delete(selection)

		selection
	end
end

def work_done!(tree,selection)
	tree.each do |key,value|
		value[:req].delete selection
	end
end

class Worker
	attr_accessor :working, :item, :finished_at
	def initialize
		@working = false
		@item = nil
		@finished_at = nil
	end
end

done = false
slots = Array.new(5){Worker.new}

current_tick = 0
while !done
	slots.each do |worker|
		if worker.finished_at == current_tick
		    worker.working = false
			work_done!(tree,worker.item)
			worker.item = nil
			worker.finished_at = nil
		end
	end
	avail = slots.select{|value| !value.working}
	avail.each do |worker|
		item = take_next!(tree)
		unless item.nil?
			worker.working = true
			worker.item = item
			worker.finished_at = current_tick + 60 + ('A'..'Z').to_a.index(item) + 1
		else
			break
		end	
	end
	if slots.select{|value| !value.working}.size == slots.size
	  done = true
	else
		current_tick+= 1
	end
end

puts current_tick

