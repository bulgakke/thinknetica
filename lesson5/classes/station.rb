require_relative '../modules/instance_counter'

class Station
  include InstanceCounter
  attr_reader :trains, :name
  
  def self.all
    @@all_stations ||= []
  end
  
  def initialize(name)
    @@all_stations ||= []
    @@all_stations << self
    self.register_instance
    @name = name
    @trains = []
  end

  def trains_by_type(type) # 'Cargo' / 'Passenger'
    @trains.select { |train| train.type == type}
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end
end