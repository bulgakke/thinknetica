numbers = (0..50).to_a
sign = ['+', '-', '*', '/']

puts "# my_first_calculator.py by AceLewis
# TODO: Make it work for all floating point numbers too

if 3/2 == 1:  # Because Python 2 does not know maths
    input = raw_input  # Python 2 compatibility

print('Welcome to this calculator!')
print('It can add, subtract, multiply and divide whole numbers from 0 to 50')
num1 = int(input('Please choose your first number: '))
sign = input('What do you want to do? +, -, /, or *: ')
num2 = int(input('Please choose your second number: '))"

sign.each do |sign|
  numbers.each do |n1|
    numbers.each do |n2|
      result = n1 + n2 if sign == '+'
      result = n1 - n2 if sign == '-'
      result = n1 * n2 if sign == '*'
      result = n1.to_f / n2 if sign == '/' && n2 != 0
      result = 'CRITICAL ERROR CRITICAL ERROR CRITICAL ERROR' if sign == '/' && n2 == 0
      puts "if num1 == #{n1} and sign == '#{sign}' and num2 == #{n2}:
      print(\"#{n1}#{sign}#{n2} = #{result}\")"
    end
  end
end

puts "print(\"Thanks for using this calculator, goodbye :)\")"
