class Station
  attr_reader :trains, :freight_trains, :passenger_trains
  
  def initialize(name)
    @name = name
    @trains = []
    @freight_trains = []
    @passenger_trains = []
  end

  def get_train(train)
    @trains << train
    @freight_trains << train if train.type == :freight
    @passenger_trains << train if train.type == :passenger 
    # списки поездов разных типов можно было кучей разных способов реализовать, тут вроде нормально
  end

  def send_train(train)
    @trains.delete(train)
    @freight_trains.delete(train)
    @passenger_trains.delete(train)
  end
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
    @station.get_train(self) # (!) здесь всё работает, в методах движения - нет
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
    @station = @next_station
    @station.get_train(self)
  end
=begin
Понятия не имею, почему, но оно не работает:
classes.rb:88:in `move_forward': undefined method `get_train' for nil:NilClass (NoMethodError)
см. строки 71 и 108
Думал вместо def get_train написать def self.get_train (и аналогично с send_train) - не помогло (да и не должно было)

Выборочно просмотрел гитхабы других людей с курса - 
ну там либо точно такая же логика, либо вообще нет связи со станцией (методы send_train и get_train есть, но они не вызываются в методах move_forward/move_back)

Можно просто убрать связь со станцией и потом каждый раз вручную в коде писать три строчки вместо одной, но как-то гм
=end
  def move_back # аналогично move_forward
    @station.send_train(self)
    @station = @prev_station
    @station.get_train(self)
  end

  def move_to(station) # сделал этот метод только для тестов, но он тоже работает
    @station.send_train(self)
    @station = station
    @station.get_train(self)
  end
end

