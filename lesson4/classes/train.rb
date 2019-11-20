class Train
  # по прошлому ТЗ все эти методы нужны для интерфейса, в private ничего не подходит
  attr_accessor :speed
  attr_reader :number, :station, :type, :wagons
  
  def initialize(number) 
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
    # смотрит индекс текущей станции в массиве маршрута, чтобы далее от него считать prev/next
  end

  def next_station
    if @route
    @route.stations[@index+1] if @station != @route.stations.last && @route
    end
    # так как маршрут не кольцевой
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
