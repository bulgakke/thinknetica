# frozen_string_literal: true

require_relative '../modules/instance_counter'
require_relative '../modules/manufacturer'
require_relative '../modules/validation'

class Train
  include InstanceCounter
  include Validation
  include Manufacturer

  TYPES = %w[Cargo Passenger].freeze # на будущее, если их больше будет
  NUMBER_FORMAT = /^[a-zа-я\d]{3}(-[a-zа-я\d]{2})?$/i.freeze

  attr_accessor :speed
  attr_reader :number, :station, :type, :wagons

  validate :number, :format, NUMBER_FORMAT
  validate :type, :equals, TYPES

  @@all_trains ||= []

  def self.find(number)
    @@all_trains.each { |train| return train if train.number == number }
    nil # если строка выше что-то найдёт, то досюда не дойдёт
  end

  def initialize(number, manufacturer = nil)
    @manufacturer = manufacturer
    @number = number
    validate!
    @wagons = []
    @speed = 0
    @@all_trains << self
    register_instance
  end

  def stop
    @speed = 0
  end

  def each_wagon(block)
    @wagons.each do |wagon|
      block.call(wagon)
    end
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && wagon.type == type
  end

  def remove_wagon
    @wagons.delete(wagon) if @speed.zero? && @wagons > 1
  end

  def acquire_route(route)
    @route = route
    @station = route.stations[0]
    @station.get_train(self)
    @index = @route.stations.index(@station)
  end

  def next_station
    return unless @route

    @route.stations[@index + 1] if @station != @route.stations.last && @route
  end

  def prev_station
    return unless @route

    @route.stations[@index - 1] if @station != @route.stations.first
  end

  def move_forward
    return unless @route

    @station.send_train(self)
    @station = next_station
    @station.get_train(self)
  end

  def move_back
    return unless @route

    @station.send_train(self)
    @station = prev_station
    @station.get_train(self)
  end
end
