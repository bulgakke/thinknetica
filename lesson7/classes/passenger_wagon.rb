require_relative 'wagon'
class PassengerWagon < Wagon
  attr_accessor :number_of_seats, :seats_free, :seats_taken

  def initialize(number_of_seats, manufacturer=nil)
    @type = 'Passenger'
    @number_of_seats = number_of_seats
    @seats_free = @number_of_seats
    @seats_taken = 0
    super
  end

  def take_seat
    @seats_taken += 1
    @seats_free -= 1
  end

  protected

  def validate!
    super
    raise 'Wrong data type, number of seats must be a number' if number_of_seats.class.superclass != Numeric
  end
end
