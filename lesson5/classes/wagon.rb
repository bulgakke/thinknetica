require_relative '../modules/manufacturer'

class Wagon
  include Manufacturer
  attr_reader :type

  def initialize(manufacturer='UNKNOWN')
    @manufacturer = manufacturer
  end
end
