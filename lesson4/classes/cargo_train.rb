require_relative 'train'
class CargoTrain < Train

  def initialize(number)
    super
    @type = 'Cargo'
  end
  def add_wagon(wagon)
    super if wagon.type == 'Cargo'
  end
end
