# frozen_string_literal: true

require_relative 'wagon'
class CargoWagon < Wagon
  attr_accessor :cargo_volume, :volume_free, :volume_taken

  def initialize(cargo_volume, manufacturer = nil)
    @type = 'Cargo'
    @cargo_volume = cargo_volume
    @volume_free = @cargo_volume
    @volume_taken = 0
    super
  end

  def load_cargo(amount)
    @volume_taken += amount
    @volume_free -= amount
  end

  protected

  def validate!
    super
    return unless cargo_volume.class.superclass != Numeric

    raise 'Wrong data type, cargo volume must be a number'
    # это я правильно делаю, или можно сделать почище?
  end
end
