require_relative '../modules/instance_counter'
require_relative '../modules/manufacturer'
require_relative '../modules/validation'

class Train
  include InstanceCounter  
  include Validation
  include Manufacturer

  attr_accessor :speed
  attr_reader :number, :station, :type, :wagons
  @@all_trains ||= []

  def self.find(number)
    @@all_trains.each { |train| return train if train.number = number }
    return nil # если строка выше что-то найдёт, то досюда не дойдёт
  end
  
  def initialize(number, manufacturer=nil) # делать проверку на уникальность указываемого номера?
    @manufacturer = manufacturer
    @number = number
    validate!
    @wagons = []
    @speed = 0
    @@all_trains << self
    self.register_instance
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

  protected

  def validate!
    TYPES = ['Cargo', 'Passenger'] # на будущее, если их больше будет
    raise 'Wrong number format, must be "xxx" or "xxx-xx", where "x" is any latin/cyrillic letter or number.' if number !~ /^[a-zа-я\d]{3}(-[a-zа-я\d]{2})?$/
    raise 'Wrong train type, must be "Cargo" or "Passenger".' unless TYPES.include?(@type)
    raise 'A train with this number already exists' if duplicate_number
  end

  def duplicate_number
    @@all_trains.each do |train|
      true if train.number == self.number
    end
    false
  end
end
