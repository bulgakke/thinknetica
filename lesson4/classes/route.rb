class Route
  attr_reader :stations, :first_station, :last_station
  # то же самое, все методы по ТЗ нужны в интерфейсе
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [@first_station, @last_station]
  end

  def add_station(name, index=-2) 
    # по дефолту добавляет станцию предпоследней
    @stations.insert(index, name) if index != -1 && index != 0 && index != @stations.size - 1
    # не дает добавить её начальной/конечной
  end

  def delete_station(name)
    @stations.delete(name) if name != @start_station && name != @last_station 
  end
end