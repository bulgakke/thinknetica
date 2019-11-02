input = gets.chomp.split(' ')
input.each do |word|
  word.chop! if word[-1].downcase == word[-1].upcase # so it doesn't do things like [ you're => youre ]
  word.concat(' ') # because the string was split by spaces
end

puts input.join