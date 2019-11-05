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
  if leap_year
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

=begin предыдущее решение (в компактном виде):
months = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 }
months[2] = 29 if leap_year

index = 0
months.each_pair { |m, d| index += d unless m >= month } 
index += day
=end

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
months[2] = 29 if leap_year
index = months.take(month - 1).sum + day

if index.digits[-1] == '1' # .to_s.reverse.chr писал в три часа ночи, сейчас вспомнил лучше
  suffix = 'st'
elsif index.digits[-1] == '2'
  suffix = 'nd'
elsif index.digits[-1] == '3'
  suffix = 'rd'
else
  suffix = 'th'
end
# украшательство

puts "The date you entered is on the #{index}#{suffix} day of the year!"
