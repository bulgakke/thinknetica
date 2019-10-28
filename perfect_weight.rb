puts "== What is your name? =="
name = gets.chomp.capitalize # Приводит имя в грамотный вид для красоты
puts "== Great, now, what's your height in centimetres? =="
height = gets.to_i
perf_weight = height - 110
if perf_weight > 0
    puts "Your optimal weight would be #{perf_weight} kilograms, #{name}!"
else
    puts "Your weight is optimal already, #{name}!"
end