require_relative '../modules/instance_counter'
require_relative '../modules/validation'

class Route
  include InstanceCounter
  include Validation
  attr_reader :stations, :first_station, :last_station
  
  def initialize(first_station, last_station)
    self.register_instance
    @first_station = first_station
    @last_station = last_station
    @stations = [@first_station, @last_station]
    validate!
  end

  def add_station(name, index=-2) 
    # по дефолту добавляет станцию предпоследней
    @stations.insert(index, name) if index != -1 && index != 0 && index != @stations.size - 1
    # не дает добавить её начальной/конечной
  end

  def delete_station(name)
    @stations.delete(name) if name != @start_station && name != @last_station 
  end

  protected

  def validate!
    raise "Use valid stations as arguments" if first_station.class != Station || last_station.class != Station
    # оно как бы и без этого ошибку выдаст (т. к. в методах есть обращения к станциям), но тут будет конкретный понятный текст
  end
end
