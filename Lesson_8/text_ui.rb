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

  def cmds
    { c1: 'Enter 1 to create a station', c2: 'Enter 3 to create a train',
      c3: 'Enter 3 to create a train', c4:  'Enter 4 to create a carriage',
      c5: 'Enter 5 to add a station to the route',
      c6: 'Enter 6 to remove a station from the route',
      c7: 'Enter 6 to remove a station from the route',
      c8: 'Enter 8 to move a train forward', c9: 'Enter 9 to move a train backward',
      c10: 'Enter 10 to add a carriage', c11: 'Enter 11 to remove a carriage',
      c12: 'Enter 12 to see a list of stations of the route',
      c13: 'Enter 13 to see a list of trains in the station',
      c14: 'Enter 14 to see a detailed list of all trains in the station',
      c15: 'Enter 15 to see a list of all carriages in the train',
      c16: 'Enter 16 to load cargo to the Cargo carriage',
      c17: 'Enter 17 to take a seat in the Passenger carriage',
      sep: '===================', menu: "\n===== MENU =====",
      exit: "Enter another key to exit\n" }
  end

  def list_commands
    puts cmds[:menu]
    puts cmds[:c1]
    puts cmds[:c2] if stations.size >= 2
    puts cmds[:c3]
    puts cmds[:c4]
    puts cmds[:sep]
    puts cmds[:c5] if routes.any?
    puts cmds[:c6] if routes.any?
    puts cmds[:c7] if routes.any? && trains.any?
    puts cmds[:c8] if trains.any? { |train| !train.route.nil? }
    puts cmds[:c9] if trains.any? && routes.any?
    puts cmds[:c10] if trains.any? && cars.any?
    puts cmds[:c11] if trains.any? { |train| train.cars.size >= 1 }
    puts cmds[:sep]
    puts cmds[:c12] if routes.any?
    puts cmds[:c13] if stations.any? { |station| station.trains.size >= 1 }
    puts cmds[:c14] if stations.any? && trains.any?
    puts cmds[:c15] if trains.any?
    puts cmds[:c16] if cars.any? { |car| car.type == 'Cargo' }
    puts cmds[:c17] if cars.any? { |car| car.type == 'Passenger' }
    puts cmds[:exit]
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
        ui_add_station if routes.any?
      when '6'
        ui_remove_station if routes.any?
      when '7'
        ui_assign_route if trains.any?
      when '8'
        ui_move_forward if trains.any?
      when '9'
        ui_move_backward if trains.any?
      when '10'
        ui_add_carriage if trains.any?
      when '11'
        ui_remove_carriage if trains.any?
      when '12'
        ui_list_stations if routes.any?
      when '13'
        ui_trains_statu if stations.any?
      when '14'
        ui_station_status if stations.any?
      when '15'
        ui_carriages_status if trains.any?
      when '16'
        ui_load_cargo if cars.any? { |car| car.type == 'Cargo' }
      when '17'
        ui_take_seat if cars.any? { |car| car.type == 'Passenger' }
      else
        exit
      end
    end
  end

  def show_all_stations
    stations.each_with_index { |station, index| puts "#{index}: #{station.name}" }
  end

  def show_all_routes
    routes.each_with_index do |route, index|
      puts "#{index}: #{route.first_station.name} - #{route.terminal_station.name}"
    end
  end

  def show_all_trains
    trains.each_with_index { |train, index| puts "#{index}: #{train.number}" }
  end

  def show_all_cars
    cars.each_with_index do |carriage, index|
      puts "#{index}: #{carriage.type}, capacity: #{carriage.capacity}, taken: #{carriage.taken}"
    end
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
      @trains[train].add_route(@routes[route])
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
    return unless @stations[station]
    if type.empty?
      @stations[station].trains_status.each { |train| puts train.number }
    else
      @stations[station].trains_status(type).each { |train| puts train.number }
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
    @trains[train].go_round do |car, index|
      puts "Carriage #{index}, type: #{car.type}, capacity: #{car.capacity}, taken: #{car.taken}"
    end
  end

  # 16
  def ui_load_cargo
    show_all_cars
    cars_msg
    car = gets.chomp.to_i
    raise 'Wrong arguments!' unless @cars[car] && @cars[car].type == 'Cargo'
    print 'Enter an amount of cargo: '
    cargo = gets.chomp.to_i
    @cars[car].load(cargo)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  # 17
  def ui_take_seat
    show_all_cars
    cars_msg
    car = gets.chomp.to_i
    raise 'Wrong arguments!' unless @cars[car] && @cars[car].type == 'Passenger'
    @cars[car].load
  rescue RuntimeError => e
    puts e.message
    retry
  end
end