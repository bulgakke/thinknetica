require_relative 'classes/route'
require_relative 'classes/station'
require_relative 'classes/passenger_train'
require_relative 'classes/passenger_wagon'
require_relative 'classes/cargo_train'
require_relative 'classes/cargo_wagon'

def return_stuff
  (1..10).to_a.each { |num| return num if Time.now.to_i.odd?}
  return nil
end