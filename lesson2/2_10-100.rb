array = []
for k in 10..100
  array << k if k % 5 == 0
end
print array
puts ''
#=========
array = []
k = 10
loop do 
  array << k
  k += 5
  break if k > 100
end
print array
puts ''
#=========
array = []
range = (-1000..1000)
range.each do |k|
  if k >= 10 && k <= 100 && k % 5 == 0 
    array << k
  end
end
print array
puts ' '
# в общем, множеством способов это можно сделать
