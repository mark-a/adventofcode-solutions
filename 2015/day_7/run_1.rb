filename = ARGV.first
txt = open(filename)

class String
  def is_integer?
    self.to_i.to_s == self
  end
end

$values = {}

def getter(gate)
  if $values[gate].is_a? Proc
	value =  $values[gate].call()
	$values[gate] = value
  end
  $values[gate]
end

txt.read.each_line do |line|
	parts = line.rstrip.split(' -> ')
	source = parts[0]
	target = parts[1]
	if source =~ /LSHIFT/
		source_parts = source.split(' LSHIFT ')
		proc = eval("Proc.new{ getter('#{source_parts[0]}') << #{source_parts[1]} }")
	elsif source =~ /RSHIFT/
		source_parts = source.split(' RSHIFT ')
		proc = eval("Proc.new{ getter('#{source_parts[0]}') >> #{source_parts[1]} }")
	elsif source =~ /AND/
		source_parts = source.split(' AND ')
		if  source_parts[0] == "1"
			proc = eval("Proc.new{ 1 & getter('#{source_parts[1]}') }")
		else
			proc = eval("Proc.new{ getter('#{source_parts[0]}') & getter('#{source_parts[1]}') }")
		end
	elsif source =~ /OR/
		source_parts = source.split(' OR ')
		proc = eval("Proc.new{ getter('#{source_parts[0]}') | getter('#{source_parts[1]}') }")
	elsif source =~ /NOT/
		source_parts = source.split('NOT ')
		proc = eval("Proc.new{ ~ getter('#{source_parts[1]}') }")
	else
		if source.is_integer?
			proc = eval("Proc.new{ #{source}.to_i }")
		else
			proc = eval("Proc.new{ getter('#{source}') }")
		end	
	end
	
	
	$values[target] = proc
end

puts getter('a')

