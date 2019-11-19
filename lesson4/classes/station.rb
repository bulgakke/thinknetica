class Station
  attr_reader :trains, :name
  # здесь тоже все методы нужны в интерфейсе. 
  # Стоило бы get_train и send_train спрятать, но тогда к ним нельзя будет отсылаться из классов поездов
  def initialize(name)
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
