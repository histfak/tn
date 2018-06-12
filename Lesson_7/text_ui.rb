class TextUi
  attr_reader :stations, :routes, :trains, :cars
  def initialize
    @stations = []
    @routes = []
    @trains = []
    @cars = []
  end

  def start
    menu
  end

  private

  def list_commands
    puts "\n===== MENU ====="
    puts 'Enter 1 to create a station'
    puts 'Enter 2 to create a route' if stations.size >= 2
    puts 'Enter 3 to create a train'
    puts 'Enter 4 to create a carriage'
    puts '==================='
    puts 'Enter 5 to add a station to the route' if routes.any?
    puts 'Enter 6 to remove a station from the route' if routes.any?
    puts 'Enter 7 to assign a route to the train' if routes.any? && trains.any?
    puts 'Enter 8 to move a train forward' if trains.any? && routes.any?
    puts 'Enter 9 to move a train backward' if trains.any? && routes.any?
    puts 'Enter 10 to add a carriage' if trains.any? && cars.any?
    puts 'Enter 11 to remove a carriage' if trains.any? && cars.any?
    puts '==================='
    puts 'Enter 12 to see a list of stations of the route' if routes.any?
    puts 'Enter 13 to see a list of trains in the station' if stations.any? && trains.any?
    puts 'Enter 14 to see a detailed list of all trains in the station' if stations.any? && trains.any?
    puts 'Enter 15 to see a list of all carriages in the train' if trains.any?
    puts 'Enter 16 to load cargo to the Cargo carriage' if cars.any? { |car| car.type == 'Cargo'}
    puts 'Enter 17 to take a seat in the Passenger carriage' if cars.any? { |car| car.type == 'Passenger'}
    puts "Enter another key to exit\n"
  end

  def menu

    loop do
      list_commands
      choice = gets.chomp
      case choice
      when '1'
        ui_create_station
      when '2'
        ui_create_route
      when '3'
        ui_create_train
      when '4'
        ui_create_carriage
      when '5'
        if routes.any?
          ui_add_station
        end
      when '6'
        if routes.any?
          ui_remove_station
        end
      when '7'
        if trains.any?
          ui_assign_route
        end
      when '8'
        if trains.any?
          ui_move_forward
        end
      when '9'
        if trains.any?
          ui_move_backward
        end
      when '10'
        if trains.any?
          ui_add_carriage
        end
      when '11'
        if trains.any?
          ui_remove_carriage
        end
      when '12'
        if routes.any?
          ui_list_stations
        end
      when '13'
        if stations.any?
          ui_trains_status
        end
      when '14'
        if stations.any?
          ui_station_status
        end
      when '15'
        if trains.any?
          ui_carriages_status
        end
      when '16'
        if cars.any? { |car| car.type == 'Cargo'}
          ui_load_cargo
        end
      when '17'
        if cars.any? { |car| car.type == 'Passenger'}
          ui_take_seat
        end
      else
        exit
      end
    end
  end

  def show_all_stations
    stations.each_with_index { |station, index| puts "#{index}: #{station.name}" }
  end

  def show_all_routes
    routes.each_with_index { |route, index| puts "#{index}: #{route.first_station.name} - #{route.terminal_station.name}" }
  end

  def show_all_trains
    trains.each_with_index { |train, index| puts "#{index}: #{train.number}" }
  end

  def show_all_cars
    cars.each_with_index { |carriage, index| puts "#{index}: #{carriage.type}, capacity: #{carriage.capacity}, taken: #{carriage.taken}" }
  end

  def stations_msg
    print 'Enter a station index: '
  end

  def routes_msg
    print 'Enter a route index: '
  end

  def trains_msg
    print 'Enter a train index: '
  end

  def cars_msg
    print 'Enter a carriage index: '
  end

  def invalid_pars
    puts 'Invalid parameters!'
  end

  # 1
  def ui_create_station
    print 'Enter a name of the station: '
    name = gets.chomp
    @stations << Station.new(name)
    puts 'The station has just been created and is in working order.'
  rescue RuntimeError => e
    puts e.message
    retry
  end

  # 2
  def ui_create_route
    show_all_stations
    print 'Enter the index of the first station: '
    st1 = gets.chomp.to_i
    print 'Enter the index of the terminal station: '
    st2 = gets.chomp.to_i
    @routes << Route.new(stations[st1], stations[st2])
    puts 'The route has just been created and is in working order.'
  rescue RuntimeError => e
    puts e.message
    retry
  end

  # 3
  def ui_create_train
    print 'Enter a number of the train: '
    number = gets.chomp
    print 'Enter a type of the train (Cargo or Passenger): '
    type = gets.chomp
    if type == 'Passenger'
      @trains << PassengerTrain.new(number)
    elsif type == 'Cargo'
      @trains << CargoTrain.new(number)
    else
      raise 'Wrong train type!'
    end
    puts 'The train has just been created and is in working order.'
  rescue RuntimeError => e
    puts e.message
    retry
  end

  # 4
  def ui_create_carriage
    print 'Enter a type of the carriage (Cargo or Passenger): '
    type = gets.chomp
    if type == 'Cargo'
      print 'Enter a capacity of the carriage: '
      capacity = gets.chomp.to_i
      @cars << CargoCarriage.new(capacity)
    elsif type == 'Passenger'
      print 'Enter a number of seats: '
      seats = gets.chomp.to_i
      @cars << PassengerCarriage.new(seats)
    else
      raise 'Wrong carriage type!'
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  # 5
  def ui_add_station
    show_all_routes
    routes_msg
    route = gets.chomp.to_i
    show_all_stations
    stations_msg
    station = gets.chomp.to_i
    if @routes[route].nil? || @stations[station].nil?
      invalid_pars
    else
      @routes[route].add_station(@stations[station])
    end
  end

  # 6
  def ui_remove_station
    show_all_routes
    routes_msg
    route = gets.chomp.to_i
    show_all_stations
    stations_msg
    station = gets.chomp.to_i
    if @routes[route].nil? || @stations[station].nil?
      invalid_pars
    else
      @routes[route].remove_station(@stations[station])
    end
  end

  # 7
  def ui_assign_route
    show_all_routes
    routes_msg
    route = gets.chomp.to_i
    show_all_trains
    trains_msg
    train = gets.chomp.to_i
    if @trains[train].nil? || @routes[route].nil?
      invalid_pars
    else
      @trains[train].set_route(@routes[route])
    end
  end

  # 8
  def ui_move_forward
    show_all_trains
    trains_msg
    train = gets.chomp.to_i
    @trains[train].move_forward if @trains[train]
  end

  # 9
  def ui_move_backward
    show_all_trains
    trains_msg
    train = gets.chomp.to_i
    @trains[train].move_backward if @trains[train]
  end

  # 10
  def ui_add_carriage
    show_all_trains
    trains_msg
    train = gets.chomp.to_i
    show_all_cars
    cars_msg
    carriage = gets.chomp.to_i
    if @trains[train].nil? || @cars[carriage].nil?
      invalid_pars
    else
      @trains[train].add_carriage(@cars[carriage])
    end
  end

  # 11
  def ui_remove_carriage
    show_all_trains
    trains_msg
    train = gets.chomp.to_i
    show_all_cars
    cars_msg
    carriage = gets.chomp.to_i
    if @trains[train].nil? || @cars[carriage].nil?
      invalid_pars
    else
      @trains[train].remove_carriage(@cars[carriage])
    end
  end

  # 12
  def ui_list_stations
    show_all_routes
    routes_msg
    route = gets.chomp.to_i
    @routes[route].list_stations if @routes[route]
  end

  # 13
  def ui_trains_status
    show_all_stations
    stations_msg
    station = gets.chomp.to_i
    print 'Enter a type of the train (Cargo or Passenger) or press "Return": '
    type = gets.chomp
    if type.empty?
      @stations[station].trains_status.each { |train| puts train.number } if @stations[station]
    else
      @stations[station].trains_status(type).each { |train| puts train.number } if @stations[station]
    end
  end

  # 14
  def ui_station_status
    show_all_stations
    stations_msg
    station = gets.chomp.to_i
    @stations[station].go_round do |train|
      puts "Train \##{train.number}, type: #{train.type}, #{train.cars.size} carriages"
    end
  end

  # 15
  def ui_carriages_status
    show_all_trains
    trains_msg
    train = gets.chomp.to_i
    index = 1
    @trains[train].go_round do |car|
      puts "Carriage #{index}, type: #{car.type}, capacity: #{car.capacity}, taken: #{car.taken}"
      index += 1
    end
  end

  # 16
  def ui_load_cargo
    show_all_cars
    cars_msg
    car = gets.chomp.to_i
    if @cars[car] && @cars[car].type == 'Cargo'
      print 'Enter an amount of cargo: '
      cargo = gets.chomp.to_i
      @cars[car].load(cargo)
    else
      raise 'Wrong arguments!'
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  # 17
  def ui_take_seat
    show_all_cars
    cars_msg
    car = gets.chomp.to_i
    if @cars[car] && @cars[car].type == 'Passenger'
      @cars[car].take_seat
    else
      raise 'Wrong arguments!'
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end
end
