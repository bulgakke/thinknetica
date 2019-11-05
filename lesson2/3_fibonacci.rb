array = [0, 1]

loop do 
  break if array[-1] + array[-2] > 100
  array << array[-1] + array[-2]
end

print array
puts ' '
#======================
array = [0, 1]

while array[-1] + array[-2] <= 100 do 
  array << array[-1] + array[-2]
end

print array
puts ' '
