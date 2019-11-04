names = []     # пока для простоты ввожу по трём отдельным массивам, потом посмотрим, есть ли смысл делать иначе
prices = []
amounts = []

loop do
  puts 'Enter the name of an item'
  names << gets.chomp
  puts 'Enter the price per unit of this item'
  prices << gets.to_f
  puts 'Enter the amount of units of this item'
  amounts << gets.to_f 
  puts 'Type "stop" if you\'ve entered everything you wanted, enter anything else if you want to continue adding items'
  stop = gets.chomp
  break if stop == 'stop'
end

price_amount_pair = prices.zip(amounts).to_h
named_hash = names.zip(price_amount_pair).to_h

puts named_hash