input = gets.chomp.downcase.chars # берём ввод в нижнем регистре, преобразуем в массив строк
k = 1 # внешний счётчик
input.each_index do |i| 
 if input[i].upcase != input[i].downcase # смотрим, можно ли поменять регистр у символа
  print input[i].upcase if k.odd? # меняем каждый второй из валидных
  print input[i] if k.even?
  k += 1 # т. е. меняет чётность только если был пройден валидный символ
 else print input[i] 
 end
end