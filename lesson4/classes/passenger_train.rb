require_relative 'train'
class PassengerTrain < Train

  def initialize(number)
    super
    @type = 'Passenger'
  end
  def add_wagon(wagon)
    if wagon.class == PassengerWagon
      super
    else
      puts "You're trying to add a wagon of mismatching type!"
    end
  end
end