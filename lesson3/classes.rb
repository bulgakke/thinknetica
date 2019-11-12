class Station
  attr_reader :trains
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type}
  end
=begin   А можно как-то так (и убрать attr_reader :trains)
  def trains(type=nil)
    @trains.select { |train| train.type == type } 
    @trains unless type
  end
=end
end

class Route
  attr_reader :stations
  
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [@first_station, @last_station]
  end

  def add_station(name, index=-2) 
    # по дефолту добавляет станцию предпоследней
    @stations.insert(index, name) if index != -1 && index != 0 
    # не дает добавить её начальной/конечной
  end

  def delete_station(name)
    @stations.delete(name) if name != @start_station && name != @last_station 
  end
end

class Train
  attr_accessor :speed
  attr_reader :number, :type, :wagons, :station
  
  def initialize(number, type, wagons) 
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @wagons += 1 if @speed == 0 
  end

  def remove_wagon
    @wagons -= 1 if @speed == 0 && @wagons > 1
  end

  def acquire_route(route)
    @route = route
    @station = route.stations[0]
    @station.get_train(self) 
    @index = @route.stations.index(@station) 
    # смотрит индекс текущей станции в массиве маршрута, чтобы далее от него считать prev/next
  end

  def next_station
    @route.stations[@index+1] if @station != @route.stations.last 
    # так как маршрут не кольцевой
  end
    

  def prev_station
    @route.stations[@index-1] if @station != @route.stations.first
  end
  
  def move_forward
    @station.send_train(self)
    @station = self.next_station
    @station.get_train(self)
  end

  def move_back 
    @station.send_train(self)
    @station = self.prev_station
    @station.get_train(self)
  end
end

