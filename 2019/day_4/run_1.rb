

count = (193651..649729).select do |num|
  nums = num.to_s.chars
  double = false
  no_decrease = true
  nums.each_with_index do |n,i|
    unless i == 0 
     if n == nums[i-1]
       double = true
     end
     if n < nums[i-1]
       no_decrease = false
     end
    end  
  end
  double && no_decrease
end

puts count.size
