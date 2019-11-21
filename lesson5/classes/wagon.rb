require_relative '../modules/manufacturer'

class Wagon
  include Manufacturer
  attr_reader :type

  def initialize(manufacturer=nil)
    @manufacturer = manufacturer
  end
end
