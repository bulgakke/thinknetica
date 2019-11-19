require_relative 'train'
class PassengerTrain < Train

  def initialize(number)
    super
    @type = 'Passenger'
  end
end
