puts 'Enter your text (please use "k" instead of "c" if it is read as [k]):'
puts '================'
input = gets.chomp.downcase.chars
puts '================'

latin = 'a b c d e f g h i j k l m n o p q r s t u v w x y z'.split' '
greek = 'α β ς δ ε φ γ η ι ζ κ λ μ η ο π ϙ ρ σ τ υ ν ω χ υ ζ'.split' '
hash = latin.zip(greek).to_h

input.each_index do |index|
  if latin.include?(input[index])
    x = latin.find_index(input[index])
    print greek[x]
  else 
    print input[index]
  end
end
puts ' '
