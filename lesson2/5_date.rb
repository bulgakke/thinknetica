puts 'Year?'
year = gets.to_i
leap_year = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 # => true/false
#можно было сделать на несколько строк с if, elsif, elsif, else, но так лучше

puts 'Month number?'
month = gets.to_i

unless (1..12).include?(month)
    puts "This doesn't seem to be valid, enter a number between 1 and 12"
    month = gets.to_i
end

puts 'Day of the month?'
day = gets.to_i

if [1, 3, 5, 7, 8, 10, 12].include?(month)
  unless (1..31).include?(day)
    puts "This doesn't seem to be valid, enter a number between 1 and 31"
    day = gets.to_i
  end
elsif [4, 6, 9, 11].include?(month)
  unless (1..30).include?(day)
    puts "This doesn't seem to be valid, enter a number between 1 and 30"
    day = gets.to_i
  end
else
  if leap_year == true
    unless (1..29).include?(day)
      puts "This doesn't seem to be valid, enter a number between 1 and 29"
      day = gets.to_i
    end
  else
    unless (1..28).include?(day)
      puts "This doesn't seem to be valid, enter a number between 1 and 28"
      day = gets.to_i
    end
  end
end

# year = 2017, month = 11, day = 4

months = { 1 => 31, 2 => 29, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 } if leap_year == true
months = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 } if leap_year == false

# да, в 43 строке "if leap_year == true" ничего не меняет, но в коде лучше и понятнее выглядит
# и в 44 можно было отдельно заменить значение второй пары, не копируя весь хэш, но опять же, бьёт по наглядности кода

index = 0

months.each_pair do |m, d| 
  unless m >= month
    index += d
  end
end

index += day

if index.to_s.reverse.chr == '1' # не нашёл, как одним методом посмотреть на последний символ числа/строки, нашёл только такое 
  suffix = 'st'
elsif index.to_s.reverse.chr == '2'
  suffix = 'nd'
elsif index.to_s.reverse.chr == '3'
  suffix = 'rd'
else
  suffix = 'th'
end
#наводим красоту 

puts "The date you entered is on the #{index}#{suffix} day of the year!"
