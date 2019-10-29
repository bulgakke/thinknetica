puts "Represent your quadratic equation in form of 'a*x^2 + b*x + c = 0'"
puts "Enter the 'a' coefficient:"
a = gets.to_f # Math.sqrt в любом случае выдает число с точкой, так что to_i применять уже нет смысла
puts "Enter the 'b' coefficient:"
b = gets.to_f
puts "Enter the 'c' coefficient:"
c = gets.to_f

d = b*b - 4*a*c
if d>0 
    x1 = (-b + Math.sqrt(d))/(2*a)
    x2 = (-b - Math.sqrt(d))/(2*a)
    puts "This equation's roots are #{x1} and #{x2}."
elsif d<0
    puts "This equation has no real roots."
else
    x = -b/(2*a)
    puts "The only root this equation has is #{x}."
end
