a = '0'
puts a
puts 'Please type this number in backwards'
loop do
  x = gets.chomp
  if x == a.reverse
    a = "#{a.chars.shuffle.join}"+"#{a.length}"
    puts "Now do the same for #{a}!"
    puts '== Keep trying, it will end soon! ==' if a.length % 5 == 0
    puts "== Don't give up, you're on your way to the finish! ==" if a.length % 7 == 0 && a.length % 5 != 0
    puts "== You're almost done, just do it three more times! ==" if a.length % 13 == 0 && a.length % 5 != 0 && a.length % 7 != 0 # it's a lie 
  else
    puts 'You seem to have mistyped it, try again!'
  end
  break if a.length == 100
end
puts 'What a good human'
