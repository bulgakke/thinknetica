cart = {}
subtotals = {}
loop do
  puts 'Enter the name of an item or type "stop" if you don\'t want to continue'
  name = gets.chomp
  break if name == 'stop'
  puts 'Enter the price per unit of this item'
  price = gets.to_f
  puts 'Enter the amount of units of this item'
  amount = gets.to_f 

  cart_part = { name => { price => amount } }
  subtotal = { name => price*amount }

  cart.merge!(cart_part)
  subtotals.merge!(subtotal)
end

puts "Here's how your cart looks like!"
cart.each do |k, v|
  print "#{k}: "
  v.each { |price, amount| print "#{price} per unit; #{amount} units total \n" }
end
puts 'This is how much each item costs you:'
subtotals.each { |name, price| puts "#{name}: #{price}" }
puts 'Here is your total price:'
puts subtotals.values.sum
