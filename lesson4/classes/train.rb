class Train
  attr_accessor :speed
  attr_reader :number, :station
  
  def initialize(number) 
    @number = number
    @wagons = []
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed == 0 
  end

  def remove_wagon
    @wagons.delete(wagon) if @speed == 0 && @wagons > 1
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