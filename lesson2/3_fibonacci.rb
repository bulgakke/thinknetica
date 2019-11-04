number = 1
array = [0]
counter = 0

loop do 
  array << number
  number += array[counter]
  counter += 1
  break if number > 100
end

print array
puts ' '
#======================
number = 1
array = [0]
counter = 0

while number <= 100 do 
  array << number
  number += array[counter]
  counter += 1
end

print array
puts ' '
