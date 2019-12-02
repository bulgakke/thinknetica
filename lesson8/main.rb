require_relative 'classes/route'
require_relative 'classes/station'
require_relative 'classes/passenger_train'
require_relative 'classes/passenger_wagon'
require_relative 'classes/cargo_train'
require_relative 'classes/cargo_wagon'

 class Menu

  def initialize
    @trains = []
    @stations = []
    @routes = []
    # для тестов, чтобы вручную не создавать каждый раз
    # @trains = [CargoTrain.new(252-52)]
    # @stations = [Station.new('qqq'), Station.new('www'), Station.new('eee')]
    # @routes = [Route.new(@stations[0], @stations[2])]
  end

  def start 
    puts 'Welcome to a railway system management model!'
    loop do
      puts "
      ################
      Choose an option:
      1. Create a train
      2. Create a station 
      3. Create a route

      4. View current trains
      5. View current stations
      6. View current routes

      7. Manage a train
      8. View a station's info
      9. Edit a route
      
      0. Exit
      ################
      "
      begin
        case gets.to_i

        when 1 
          create_train
        when 2
          create_station
        when 3
          create_route
        when 4
          view_trains
        when 5
          view_stations
        when 6 
          view_routes
        when 7
          manage_train
        when 8
          view_station_info
        when 9 
          edit_route
        when 0 
          break
        else
          puts 'Enter a number from the list'
        end
      rescue RuntimeError => e
        puts e
      end        
    end
  end
  
  private
  
  def create_train # 1
    puts 'Enter an index number for your train:'
    new_train_number = gets.chomp
    puts 'Choose a type of your train:
      1. Cargo
      2. Passenger'
      
      case gets.to_i
        when 1 # Create a train > Cargo
          @trains << CargoTrain.new(new_train_number)
          puts 'A new train has successfully been created!'
        when 2 # Create a train > Passenger
          @trains << PassengerTrain.new(new_train_number)
          puts 'A new train has successfully been created!'
      end
  end
  
  def create_station # 2
    puts 'Enter a name for you station:'
    new_station_name = gets.chomp
    @stations << Station.new(new_station_name)
  end
  
  def create_route # 3
    puts 'Pick the first station for your new route:'
    @stations.each_with_index do |station, index|
      puts "#{index+1}. #{station.name}"
    end
    first_station = @stations[gets.to_i - 1]
    
    puts 'Pick the last station for your new route:'
    @stations.each_with_index do |station, index|
      puts "#{index+1}. #{station.name}"
    end
    last_station = @stations[gets.to_i - 1]
    
    @routes << Route.new(first_station, last_station) if first_station && last_station
  end
  
  def view_trains # 4
    puts 'How would you like the list to be presented?
    1. Detailed form
    2. Short form
    3. View each train info'
    case gets.to_i
    when 1 # View current trains > Detailed form
      puts "Current trains (#{@trains.size} overall):"
      @trains.each do |train|
        puts "Number: #{train.number} 
        type: #{train.type}, 
        wagons attached: #{train.wagons.size}, 
        previous station: #{train.prev_station}, 
        current station: #{train.station}
        next station: #{train.next_station}."
      end
    when 2 # View current trains > Short form
      puts "Current trains (#{@trains.size} overall):"
      @trains.each do |train|
        print "#{train.number} "
      end
      puts ''
    when 3 # View current trains > View each train info
      puts "Current trains (#{@trains.size} overall):"
      @trains.each do |train|
        puts "Number: #{train.number}"
        wagon_number = 1 # можно
        train.each_wagon do |wagon|

          puts "Wagon number: #{wagon_number}
          Wagon type: #{wagon.type}"
          puts "Overall seats: #{wagon.number_of_seats}; free: #{wagon.seats_free}; taken: #{wagon.seats_taken}" if wagon.type = 'Passenger'
          puts "Overall cargo volume: #{wagon.cargo_volume}; free: #{wagon.volume_free}; taken: #{wagon.volume_taken}" if wagon.type = 'Cargo'
          wagon_number += 1
        end
      end
    end
  end
  
  def view_stations # 5
    puts 'How would you like the list to be presented?
    1. Detailed form
    2. Short form
    3. View each station info'
    case gets.to_i
    when 1 # View current stations > Detailed form
      puts "Current stations (#{@stations.size} overall):"
      @stations.each do |station|
        puts "Name: #{station.name} 
        trains at the station: #{station.trains.size}, 
        of them cargo: #{station.trains_by_type('Cargo').size}, 
        passenger: #{station.trains_by_type('Passenger').size}"
      end
    when 2 # View current stations > Short form
      puts "Current stations (#{@stations.size} overall):"
      @stations.each do |station|
        print "#{station.name} "
      end
      puts ''
    when 3 # View current stations > View each station info
      puts "Current stations (#{@stations.size} overall):"
      @stations.each do |station|
        puts "Name: #{station.name}"
        station.each_train do |train|
          puts "Train number: #{train.number}
          train type: #{train.type}
          amount of wagons: #{train.wagons.length}
          "
        end
      end
    end
  end
  
  def view_routes # 6
    puts 'How would you like the list to be presented?
    1. Detailed form
    2. Short form'
    case gets.to_i
    when 1 # View current routes > Detailed form
      @routes.each do |route|
        route.stations.each { |station| print "#{station.name} "}
      end
    when 2 # View current routes > Short form
      @routes.each do |route|
        puts "#{route.first_station.name} --> #{route.last_station.name}"
      end
    end    
  end
  
  def manage_train # 7
    puts 'Pick a train:'
    @trains.each_with_index do |train, index|
      puts "#{index+1}. #{train.number}"
    end
    train_to_manage = @trains[gets.to_i - 1] until train_to_manage 
    # здесь и далее - until не даёт присвоить переменной nil
    # т. е. защита от кривого gets.to_i
    puts 'Choose what you want to do with it:
    1. Assign a route
    2. Add wagons
    3. Remove wagons 
    4. Move forward on the route
    5. Move back on the route
    6. Load cargo or sit passengers'
    case gets.to_i
    when 1 # Manage a train > Assign a route
      @routes.each_with_index do |route, index|
        puts "#{index+1}. #{route.first_station.name} --> #{route.last_station.name}"
      end
      route_to_assign = @routes[gets.to_i - 1] until route_to_assign
      train_to_manage.acquire_route(route_to_assign)
    when 2 # Manage a train > Add wagons
      puts 'Choose the number of wagons to add:'
      wagons_to_add = gets.to_i # если этой строки нет, то в строке ниже undefined method `<' for nil:NilClass
      wagons_to_add = gets.to_i until wagons_to_add > 0

      for counter in (1..wagons_to_add) do
        if train_to_manage.class == CargoTrain
          puts 'Enter the volume of cargo this wagon can carry:'
          cargo_volume = gets.to_f # по логике, эта величина в общем случае не целочисленная
          train_to_manage.add_wagon(CargoWagon.new(cargo_volume)) 
        end

        if train_to_manage.class == PassengerTrain
          puts 'Enter the number of seats this wagon has:'
          number_of_seats = gets.to_i
          train_to_manage.add_wagon(PassengerWagon.new(number_of_seats)) 
        end
      end

    when 3 # Manage a train > Remove wagons
      puts 'Choose the number of wagons to remove:'
      wagons_to_remove = gets.to_i # если этой строки нет, то в строке ниже undefined method `<' for nil:NilClass
      wagons_to_remove = gets.to_i until wagons_to_remove > 0
      for counter in (1..wagons_to_remove) do
        train_to_manage.remove_wagon(CargoWagon.new) if train_to_manage.class == CargoTrain
        train_to_manage.remove_wagon(PassengerWagon.new) if train_to_manage.class == PassengerTrain
      end
    when 4 # Manage a train > Move forward on the route
      train_to_manage.move_forward
    when 5 # Manage a train > Move back on the route
      train_to_manage.move_back
    when 6 # Manage a train > Load cargo or sit passengers
      puts "Enter the number of the wagon you want to manage: (this train has #{train_to_manage.wagons.size}):"
      input = gets.to_i until (0..train_to_manage.wagons.size) === input - 1
      wagon_to_manage = train_to_manage.wagons[input - 1]
      if wagon_to_manage.type = 'Cargo'
        puts 'Enter the amount of volume you want to fill:'
        amount = gets.to_f
        wagon_to_manage.load_cargo(amount)
      elsif wagon_to_manage.type = 'Passenger'
        puts 'Enter the amount of passengers you want to sit:'
        amount = gets.to_i
        for i in 1..amount do 
          wagon_to_manage.take_seat
        end
        
      end
    end
  end
  
  def view_station_info # 8
    puts 'Choose a station to view info about:'
    @stations.each_with_index do |station, index|
      puts "#{index+1}. #{station.name}"
    end
    station_to_view = @stations[gets.to_i - 1] until station_to_view

    station_to_view.each_train do |train| # было station_to_view.trains.each do |train|
      puts "Train number: #{train.number}
      train type: #{train.type}
      amount of wagons: #{train.wagons.length}
      "
    end

  end
  
  def edit_route # 9
    puts 'Choose a route you want to edit:'
    @routes.each_with_index do |route, index|
      puts "#{index+1}. #{route.first_station.name} --> #{route.last_station.name}"
    end
    route_to_edit = @routes[gets.to_i - 1] until route_to_edit
    puts '
    1. Delete a station
    2. Add a station'
    case gets.to_i
    when 1 # Edit a route > Delete a station
      puts "Choose a station you want to delete (can't edit the first and the last stations):"
      route_to_edit.stations.each_with_index do |station, index|
        puts "#{index+1}. #{station.name}"
      end
      station_to_delete = stations[gets.to_i - 1] until station_to_delete
      route_to_edit.delete_station(station_to_delete)
      
    when 2 # Edit a route > Add a station
      puts 'Choose a station you want to add to this route:'
      @stations.each_with_index do |station, index|
        puts "#{index+1}. #{station.name}"
      end
      station_to_add = @stations[gets.to_i - 1] until station_to_add
      puts "Choose a station your new station will be added before (can't be 1):"
      route_to_edit.stations.each_with_index do |station, index|
        puts "#{index+1}. #{station.name}"
      end
      station_to_add_place = gets.to_i - 1 # если этой строки нет, то в строке ниже undefined method `<' for nil:NilClass
      station_to_add_place = gets.to_i - 1 until station_to_add_place < stations.length
      route_to_edit.add_station(station_to_add, station_to_add_place)
    end
  end
end

Menu.new.start
