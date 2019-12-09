# frozen_string_literal: true

require_relative '../modules/manufacturer'
require_relative '../modules/validation'

class Wagon
  include Manufacturer
  include Validation

  TYPES = %w[Cargo Passenger].freeze

  validate :type, :equals, TYPES
  attr_reader :type

  def initialize(manufacturer = nil)
    @manufacturer = manufacturer
    validate!
  end
end
