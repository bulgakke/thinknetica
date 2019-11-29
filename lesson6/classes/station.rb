require_relative '../modules/instance_counter'
require_relative '../modules/validation'

class Station
  include InstanceCounter
  include Validation
  attr_reader :trains, :name
  
  def self.all
    @@all_stations ||= []
  end
  
  def initialize(name)
    @name = name
    validate! # как я понял, здесь нужно именно так? А затем обработать это исключение в main.rb?
    @@all_stations ||= []
    @@all_stations << self
    self.register_instance
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

  # Для простоты начнём со станций
  # Конкретного ТЗ нет, выдумаю сам

  protected

  def validate!
    raise "The name length should be between 3 and 15 characters." unless (3..15) === name.length
    raise "You can only use Latin and Cyrillic, numbers, spaces, '-' and '_'." if invalid_chars?
  end

  def invalid_chars?
    allowed = ('A'..'Z').to_a + ('a'..'z').to_a + ('А'..'Я').to_a + ('а'..'я').to_a + ('0'..'9').to_a + ['-', '_', ' '] # см. 45
  # ничего, что я в таких случаях return пишу? 
  # и самому понятнее, что происходит, и вообще на всякий случай
  @name.chars.each do |character|
    if allowed.include?(character) == false
      return true
      break
    end
  end
  return false
  end

end