require_relative '../modules/instance_counter'
require_relative '../modules/manufacturer'

class Train
  include InstanceCounter
  include Manufacturer

  attr_accessor :speed
  attr_reader :number, :station, :type, :wagons

  def self.find(number)
    @@all_trains.each { |train| return train if train.number = number }
    return nil # если строка выше что-то найдёт, то досюда не дойдёт
  end
  
  def initialize(number, manufacturer='UNKNOWN') # делать проверку на уникальность указываемого номера?
    @@all_trains ||= []
    @@all_trains << self
    self.register_instance
    @manufacturer = manufacturer
    @number = number
    @wagons = []
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed == 0 && wagon.type == self.type
  end

  def remove_wagon
    @wagons.delete(wagon) if @speed == 0 && @wagons > 1
  end

  def acquire_route(route)
    @route = route
    @station = route.stations[0]
    @station.get_train(self) 
    @index = @route.stations.index(@station) 
  end

  def next_station
    if @route
    @route.stations[@index+1] if @station != @route.stations.last && @route
    end
  end
    

  def prev_station
    if @route
    @route.stations[@index-1] if @station != @route.stations.first
    end
  end
  
  def move_forward
    if @route 
      @station.send_train(self)
      @station = self.next_station
      @station.get_train(self)
    end
  end

  def move_back 
    if @route
      @station.send_train(self)
      @station = self.prev_station
      @station.get_train(self)
    end
  end
end
