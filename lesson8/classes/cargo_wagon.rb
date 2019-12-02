require_relative 'wagon'
class CargoWagon < Wagon
  attr_accessor :cargo_volume, :volume_free, :volume_taken

  def initialize(cargo_volume, manufacturer=nil)
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
    raise 'Wrong data type, cargo volume must be a number' if cargo_volume.class.superclass != Numeric
    # это я правильно делаю, или можно сделать почище?
  end
end
