require_relative 'train'
class PassengerTrain < Train

  def initialize(number)
    super
    @type = 'Passenger'
  end
  def add_wagon(wagon)
    super if wagon.type == 'Passenger'
  end
end
