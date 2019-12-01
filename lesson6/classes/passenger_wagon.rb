require_relative 'wagon'
class PassengerWagon < Wagon
  def initialize(manufacturer=nil)
    @type = 'Passenger'
    super
  end
end
