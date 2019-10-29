puts 'Enter the length of the 1nd side'
a = gets.to_i
puts 'Enter the length of the 2nd side'
b = gets.to_i
puts 'Enter the length of the 3rd side'
c = gets.to_i
a, b, c = [a, b, c].sort # 'c' будет наибольшим значением

if c**2 == a**2 + b**2
  statement1 = 'The triangle you described is a right triangle! Also, '
else 
  statement1 = 'The triangle you described is not a right triangle, but '
end

if a == b && a == c
  statement2 = 'it is equilateral.' # Равносторонний
elsif 
  a==b || a==c || b==c
  statement2 = 'it is isosceles.' # Равнобедренный.
                                  # Равносторонний треугольник по определению является равнобедренным, так что использовать оба эти описания одновременно не имеет смысла
elsif c**2 == a**2 + b**2
  statement1 = 'The triangle you described is a right triangle! ' # Прямоугольный и разносторонний
else
  statement1 = "The triangle you described isn't a right triangle and none of its sides are equal. There's not much special about it."
end

unless statement2            # если использовать просто puts stmnt1+stmnt2, то ругается на ошибку типов (думает, что stmnt == nil, т. к. ветки, 
  puts statement1             # в которых туда что-то писалось, не выполнялись). Другой способ обойти - в каждой ветке прописать значение в 
else 
  puts statement1+statement2     # переменную stmnt2, но данный способ мне показался элегантнее.
end

=begin
С расчётами-то проблем не возникло; неочевидно было, каким образом организовать вывод результатов.
Учитывая, что и прямоугольныe, и не прямогульныe треугольники могут быть 
как равнобедренными, так и разносторонними, пришлось чересчур сложную схему организовать.
Если не заморачиваться с математическими и лингвистическими тонкостями (не пытаться
писать складный текст или строго относитться к математическим критериям), то было бы намного проще.

Да, код немного захламлён, но в угоду эстетичности со стороны юзера.
=end

# Изменены названия переменных, починены кавычки, табуляция и пробелы вокруг операторов, используется определение наибольшего значения через сортировку массива,
# 30-я строка отбита от else на 29-й, в конце пустая строка.
