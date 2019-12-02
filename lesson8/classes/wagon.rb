require_relative '../modules/manufacturer'
require_relative '../modules/validation'

class Wagon
  include Manufacturer
  include Validation
  attr_reader :type

  def initialize(manufacturer=nil)
    @manufacturer = manufacturer
    validate!
  end

protected

  def validate!
    raise 'Wrong wagon type, must be "Cargo" or "Passenger".' unless TYPES.include?(@type)
  end
end
