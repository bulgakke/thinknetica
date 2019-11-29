valid_types = ['Cargo', 'Passenger'] 
type = 'Cargo'
puts 'Wrong train type, should be "Cargo" or "Passenger"' unless valid_types.include?(type)
puts 'Its okay' if valid_types.include?(type)