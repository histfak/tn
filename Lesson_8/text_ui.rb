class TextUi
  attr_reader :stations, :routes, :trains, :cars

  CMDS = { c1: 'Enter 1 to create a station', c2: 'Enter 3 to create a train',
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
           exit: "Enter another key to exit\n" }.freeze

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

  # rubocop:disable all
  def list_commands
    puts CMDS[:menu]
    puts CMDS[:c1]
    puts CMDS[:c2] if stations.size >= 2
    puts CMDS[:c3]
    puts CMDS[:c4]
    puts CMDS[:sep]
    puts CMDS[:c5] if routes.any?
    puts CMDS[:c6] if routes.any?
    puts CMDS[:c7] if routes.any? && trains.any?
    puts CMDS[:c8] if trains.any? { |train| !train.route.nil? }
    puts CMDS[:c9] if trains.any? && routes.any?
    puts CMDS[:c10] if trains.any? && cars.any?
    puts CMDS[:c11] if trains.any? { |train| train.cars.size >= 1 }
    puts CMDS[:sep]
    puts CMDS[:c12] if routes.any?
    puts CMDS[:c13] if stations.any? { |station| station.trains.size >= 1 }
    puts CMDS[:c14] if stations.any? && trains.any?
    puts CMDS[:c15] if trains.any?
    puts CMDS[:c16] if cars.any? { |car| car.type == 'Cargo' }
    puts CMDS[:c17] if cars.any? { |car| car.type == 'Passenger' }
    puts CMDS[:exit]
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

  # rubocop:enable all
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

  def show_cargo_cars
    cars.each_with_index do |carriage, index|
      puts "#{index}: capacity: #{carriage.capacity}, taken: #{carriage.taken}" \
      if carriage.type == 'Cargo'
    end
  end

  def show_passenger_cars
    cars.each_with_index do |carriage, index|
      puts "#{index}: capacity: #{carriage.capacity}, taken: #{carriage.taken}" \
      if carriage.type == 'Passenger'
    end
  end

  def choose_carriage
    show_all_cars
    cars_msg
    index = gets.chomp.to_i
    @cars[index]
  end

  def choose_cargo_carriage
    show_cargo_cars
    cars_msg
    index = gets.chomp.to_i
    @cars[index]
  end

  def choose__passenger_carriage
    show_passenger_cars
    cars_msg
    index = gets.chomp.to_i
    @cars[index]
  end

  def choose_train
    show_all_trains
    trains_msg
    index = gets.chomp.to_i
    @trains[index]
  end

  def choose_station
    show_all_stations
    stations_msg_msg
    index = gets.chomp.to_i
    @stations[index]
  end

  def choose_route
    show_all_routes
    routes_msg
    index = gets.chomp.to_i
    @routes[index]
  end

  def wrong_choice?(*args)
    args.any?(&:nil?)
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
    route = choose_route
    station = choose_station
    if wrong_choice?(route, station)
      invalid_pars
    else
      route.add_station(station)
    end
  end

  # 6
  def ui_remove_station
    route = choose_route
    station = choose_station
    if wrong_choice?(route, station)
      invalid_pars
    else
      route.remove_station(station)
    end
  end

  # 7
  def ui_assign_route
    route = choose_route
    train = choose_train
    if wrong_choice?(route, train)
      invalid_pars
    else
      train.add_route(route)
    end
  end

  # 8
  def ui_move_forward
    train = choose_train
    train.move_forward if train
  end

  # 9
  def ui_move_backward
    train = choose_train
    train.move_backward if train
  end

  # 10
  def ui_add_carriage
    train = choose_train
    carriage = choose_carriage
    if wrong_choice?(train, carriage)
      invalid_pars
    else
      train.add_carriage(carriage)
    end
  end

  # 11
  def ui_remove_carriage
    train = choose_train
    carriage = choose_carriage
    if wrong_choice?(train, carriage)
      invalid_pars
    else
      train.remove_carriage(carriage)
    end
  end

  # 12
  def ui_list_stations
    route = choose_route
    route.list_stations if route
  end

  # 13
  def ui_trains_status
    station = choose_station
    print 'Enter a type of the train (Cargo or Passenger) or press "Return": '
    type = gets.chomp
    return unless station
    if type.empty?
      station.trains_status.each { |train| puts train.number }
    else
      station.trains_status(type).each { |train| puts train.number }
    end
  end

  # 14
  def ui_station_status
    station = choose_station
    station.go_round do |train|
      puts "Train \##{train.number}, type: #{train.type}, #{train.cars.size} carriages"
    end
  end

  # 15
  def ui_carriages_status
    train = choose_train
    train.go_round do |car, index|
      puts "Carriage #{index}, type: #{car.type}, capacity: #{car.capacity}, taken: #{car.taken}"
    end
  end

  # 16
  def ui_load_cargo
    carriage = choose_cargo_carriage
    raise 'Wrong arguments!' unless carriage
    print 'Enter an amount of cargo: '
    cargo = gets.chomp.to_i
    carriage.load(cargo)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  # 17
  def ui_take_seat
    carriage = choose__passenger_carriage
    raise 'Wrong arguments!' unless carriage
    carriage.load
  rescue RuntimeError => e
    puts e.message
    retry
  end
end
