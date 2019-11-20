time = Time.now.to_i
(1..10).to_a.each do |value|
  puts 'before'
  break if Time.now.to_i >= time+33
end
puts 'after'