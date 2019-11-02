puts 'This program will redact out a certain word from a text you provide.'
puts 'Input the text, from which the word will be redacted:'
puts '====================================================='
print '>>> '
text = gets.chomp
puts '====================================================='
puts 'Now input the words you want to redact (not case-sensitive), use spaces to split them:'
puts '====================================================='
print '>>> '
redact = gets.chomp.downcase.split(' ')
puts '====================================================='
array = []
words = text.split(' ')

words.each do |word|
  if word[-1].downcase == word[-1].upcase
    word_copy = word.chop!
  else
    word_copy = word
  end
  if redact.include?(word_copy.downcase)
    if word[-1].downcase == word[-1].upcase
      array << "#######{word[-1]} " 
    else array << "###### "
    end
  else
  array << "#{word} "
  end
end

puts array.join
puts 'IT DID NOTHING' if array.join == "#{text}+' '" || array.join == text
