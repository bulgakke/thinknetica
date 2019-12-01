require_relative 'wagon'
class CargoWagon < Wagon
  def initialize(manufacturer=nil)
    @type = 'Cargo'
    super
  end
end
