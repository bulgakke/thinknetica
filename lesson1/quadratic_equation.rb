puts "Represent your quadratic equation in form of 'a*x^2 + b*x + c = 0'"
puts "Enter the 'a' coefficient:"
a = gets.to_f # Math.sqrt в любом случае выдает число с точкой, так что to_i применять уже нет смысла
puts "Enter the 'b' coefficient:"
b = gets.to_f
puts "Enter the 'c' coefficient:"
c = gets.to_f

if d > 0 
  sqrtd = Math.sqrt(b * b - 4 * a * c)
  x1 = (- b + sqrtd) / (2 * a)
  x2 = (- b - sqrtd) / (2 * a)
  puts "This equation's roots are #{x1} and #{x2}."
elsif d == 0
  x = - b / (2 * a)
  puts "The only root this equation has is #{x}."
  
else
  puts 'This equation has no real roots.'
end

# Расставлены пробелы вокруг операторов, корень из D вычисляется один раз, починены кавычки (только в строке 15) и табуляция, в конце - пустая строка.
