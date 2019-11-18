require_relative 'train'
class CargoTrain < Train

  def initialize(number)
    super
    @type = 'Cargo'
  end
  def add_wagon(wagon)
    if wagon.class == CargoWagon
      super
    else
      puts "You're trying to add a wagon of mismatching type!"
    end
  end
end