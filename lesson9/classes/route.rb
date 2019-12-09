# frozen_string_literal: true

require_relative '../modules/instance_counter'
require_relative '../modules/validation'

class Route
  include InstanceCounter
  include Validation
  attr_reader :stations, :first_station, :last_station

  validate :first_station, :class, Station
  validate :last_station, :class, Station

  def initialize(first_station, last_station)
    register_instance
    @first_station = first_station
    @last_station = last_station
    @stations = [@first_station, @last_station]
    validate!
  end

  def add_station(name, index = -2)
    # по дефолту добавляет станцию предпоследней
    return unless index != -1 && index != 0 && index != @stations.size - 1

    @stations.insert(index, name)
    # не дает добавить её начальной/конечной
  end

  def delete_station(name)
    @stations.delete(name) if name != @start_station && name != @last_station
  end
end
