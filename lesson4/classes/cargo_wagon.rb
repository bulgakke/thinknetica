require_relative 'wagon'
class CargoWagon < Wagon
  def initialize
    @type = 'Cargo'
  end
end
