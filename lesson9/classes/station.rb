# frozen_string_literal: true

require_relative '../modules/instance_counter'
require_relative '../modules/validation'

class Station
  include InstanceCounter
  include Validation
  attr_reader :trains, :name
  validate :name, :characters

  def self.all
    @@all_stations ||= []
  end

  def initialize(name)
    @name = name
    validate! # как я понял, здесь нужно именно так? А затем обработать это исключение в main.rb?
    @@all_stations ||= []
    @@all_stations << self
    register_instance
    @trains = []
  end

  def each_train(block)
    @trains.each do |train|
      block.call(train)
    end
  end

  def trains_by_type(type)
    # 'Cargo' / 'Passenger'
    @trains.select { |train| train.type == type }
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end
end
