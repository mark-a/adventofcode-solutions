require 'digest'

found4 = false
found6 = false
counter = 0

while !found4 || !found6
  md5 = Digest::MD5.new
  md5 << 'bgvyzdsv' + counter.to_s

  if !found4 && md5.hexdigest[0..3] == '0000'
    found4 = true
    puts "found 4 zeros with counter "+ counter.to_s
  end
  if md5.hexdigest[0..5] == '000000'
    found6 = true
    puts "found 6 zeros with counter "+ counter.to_s
  end
  counter +=1
end
