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

  def trains_by_type(type) # CargoTrain / PassengerTrain
    @trains.select { |train| train.class == type}
  end
end