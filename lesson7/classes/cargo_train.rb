require_relative 'train'
class CargoTrain < Train

  def initialize(number)
    @type = 'Cargo'
    super
  end
end
