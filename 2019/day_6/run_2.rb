h={}
c= $<.map{|x|a,b=x.chomp.split (?))
(h[b]||h[b]=[])<<a
(h[a]||h[a]=[])<<b}
#p h
j=h#.invert.transform_values{|x|[x]}
#p j
a=['YOU']
s=0
k=a*1
(
p a
a=a.map{|b|h[b]}.flatten
a-=k
k|=a
s+=1)until a.any?{|x|x=="SAN"}||!a[0]
p s-2