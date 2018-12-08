class Node
	attr_accessor :children, :meta, :value
	
	def initialize
		@children = []
		@meta = []
		@value = 0
	end
end

def recurse(list,nodes)
	num_child = list.next
	num_meta = list.next

	element = Node.new
	num_child.times do
		element.children.push recurse(list,nodes)
	end

	num_meta.times do
		element.meta.push list.next
	end
	
	if element.children.size == 0
		element.value = element.meta.sum
	else
		value = 0
		element.meta.each do |ref|
			index = ref-1
			if index >= 0 && index < element.children.size
				value +=  element.children[index].value
			end
		end
		element.value = value
	end
	
	nodes.push element
	element
end

filename = ARGV.first
txt = open(filename)

list = txt.read.chomp.split(' ').map(&:to_i).each

nodes = []
tree = recurse(list,nodes)

puts  nodes.map(&:meta).flatten.sum
puts tree.value
