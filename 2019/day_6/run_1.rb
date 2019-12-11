filename = ARGV.first
txt = open(filename)

ORBIT_TREE = Hash.new()


txt.read.each_line do |line|
  parent,child = line.chomp.split (")")
  ORBIT_TREE[child] = parent
end

counter = 0
ORBIT_TREE.map do |x,y|
    
    path=[y]
    current=path.clone

    while current.any? 
        work = current
        current = current.map{|c|ORBIT_TREE[c]}.flatten
        path = (path += current).uniq
        current-=work
    end

    # anti nil
    path.pop

    counter += path.size
end

puts counter
