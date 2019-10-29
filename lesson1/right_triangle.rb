puts "Enter the length of the 1nd side"
a = gets.to_i
puts "Enter the length of the 2nd side"
b = gets.to_i
puts "Enter the length of the 3rd side"
c = gets.to_i

if (a**2 == b**2 + c**2) || (b**2 == a**2 + c**2) || (c**2 == a**2 + b**2) # А зачем тратить строчки на выяснение самой длинной стороны, если всё равно сравнивать квадраты?
    stmnt1 = "The triangle you described is a right triangle! Also, "
else stmnt1 = "The triangle you described is not a right triangle, but "
end

if a==b && a==c
    stmnt2 = "it is equilateral." # Равносторонний
elsif 
    a==b || a==c || b==c
    stmnt2 = "it is isosceles." # Равнобедренный.
                                # Равносторонний треугольник по определению является равнобедренным, так что использовать оба эти описания одновременно не имеет смысла
elsif (a**2 == b**2 + c**2) || (b**2 == a**2 + c**2) || (c**2 == a**2 + b**2) 
    stmnt1 = "The triangle you described is a right triangle! " # Прямоугольный и разносторонний
else
    stmnt1 = "The triangle you described isn't a right triangle and none of its sides are equal. There's not much special about it."
    end

if stmnt2 == nil            # если использовать просто puts stmnt1+stmnt2, то ругается на ошибку типов (думает, что stmnt == nil, т. к. ветки, 
    puts stmnt1             # в которых туда что-то писалось, не выполнялись). Другой способ обойти - в каждой ветке прописать значение в 
else puts stmnt1+stmnt2     # переменную stmnt2, но данный способ мне показался элегантнее.
end

=begin
С расчётами-то проблем не возникло; неочевидно было, каким образом организовать вывод результатов.
Учитывая, что и прямоугольныe, и не прямогульныe треугольники могут быть 
как равнобедренными, так и разносторонними, пришлось чересчур сложную схему организовать.
Если не заморачиваться с математическими и лингвистическими тонкостями (не пытаться
писать складный текст или строго относитться к математическим критериям), то было бы намного проще.

Да, код немного захламлён, но в угоду эстетичности со стороны юзера.
=end
