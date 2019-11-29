require_relative '../modules/manufacturer'
require_relative '../modules/validation'

class Wagon
  include Manufacturer
  include Validation # тут пока вроде нечего, на будущее положил
  attr_reader :type

  def initialize(manufacturer=nil)
    @manufacturer = manufacturer
  end
end
