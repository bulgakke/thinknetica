puts "== What's the length of the base of the triangle? =="
base = gets.to_f
puts "== What's the lenght of the height of the triangle? =="
height = gets.to_f
area = base * height / 2
puts "== The area of this triangle equals #{area} =="

# пробелы вокруг операторов, метод .to_i заменен на .to_f (присутствует деление пополам, и даже при вводе целых чисел часто будут недопустимые округления)
