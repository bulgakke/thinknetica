class Station
  
  def initialize(name)
    @name = name
    @trains = {}
  end

  def get_train(train)
    @trains[train] = train.type # вот это почему-то не работает. Если что, я пытаюсь дать ему объект класса "поезд" и сопоставить значением тип этого поезда
  end

  def send_train(train)
    @trains.delete(train)
  end
  
  def trains_here
    return @trains.keys
  end

  def trains_of_type(train_type)
    @amount_of_this_type = @trains.select { |train, type| type = train_type}
    return @amount_of_this_type.size
  end

end


class Route

  def initialize(start_station, last_station)
    @stations = [start_station, last_station]
  end

  def add_station(name, index=-2)
    @stations.insert(index, name) # по дефолту добавляет станцию предпоследней
  end

  def delete_station(name)
    @stations.delete(name)
  end

  def stations
    return @stations # оставил в таком виде для целесообразности коммента
    # я честно путаюсь между return, puts и просто указанием переменной внутри метода, помогите
    # и нужно оно вообще, или достаточно attr_reader :stations ?
  end

end


class Train
  attr_accessor :speed
  attr_reader :number
  attr_reader :type
  attr_reader :wagons_amount
  
  def initialize(number, type, wagons_amount) # type = :freight || :passenger; можно ли и надо ли ограничивать ввод двумя этим опциями?
    @number = number
    @type = type
    @wagons_amount = wagons_amount
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @wagons_amount += 1 if @speed == 0 
  end
  
  def remove_wagon
    @wagons_amount -= 1 if @speed == 0 && @wagons_amount > 1 # надо возвращать что-то, если поезд в движении или состоит из одного вагона?
  end

  def acquire_route(route)
    @current_route = route
    @prev_station = route.stations[-1] # допускаем, что маршрут кольцевой?
    @current_station = route.stations[0]
    @next_station = route.stations[1]
  end

  def status
    puts "Current station is #{@current_station}"
    puts "Next station is #{@next_station}"
    puts "Previous station is #{@prev_station}"
  end

  def move_forward
    @prev_station = @current_station
    @current_station.send_train(self)
    @current_station = @next_station
    @next_station = @current_route.stations[@current_route.stations.index(@next_station)+1] # вот тут понятия не имею, как сделать лучше
    @current_station.get_train(self)
  end

  def move_back
    @next_station = @current_station
    @current_station.send_train(self)
    @current_station = @prev_station
    @prev_station = @current_route.stations[@current_route.stations.index(@prev_station)-1]
    @current_station.get_train(self)
  end
end
