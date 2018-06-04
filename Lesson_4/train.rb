class Train
  attr_reader :number, :type, :speed, :station, :route, :cars

  def initialize(number, type)
    @number = number
    @type = type
    @cars = []
    @speed = 0
  end

  def set_route(route)
    @route = route
    @station = route.first_station
    route.first_station.train_arrival(self)
  end

  def increase_speed(value)
    @speed += value
  end

  def decrease_speed(value)
    @speed -= value if @speed - value > 0
  end

  def add_carriage(carriage)
    if speed.zero?
      @cars << carriage
    else
      puts 'You can\'t add the carriage in motion!'
    end
  end

  def remove_carriage
    if cars.empty?
      puts 'The train has no carriages!'
    elsif speed.zero?
      @cars.pop
    else
      puts 'You can\'t remove the carriage in motion!'
    end
  end

  def cars_number
    @cars.size
  end

  def current_station
    @station
  end

  def previous_station
    route.stations[station_index - 1] if station_index != 0
  end

  def next_station
    route.stations[station_index + 1] if station_index != route.stations.size - 1
  end

  def move_forward
    @station.train_departure(self)
    @station = route.stations[station_index.next]
    @station.train_arrival(self)
  end

  def move_backward
    @station.train_departure(self)
    @station = route.stations[station_index.pred]
    @station.train_arrival(self)
  end

  private

  def station_index
    route.stations.index(@station)
  end
end
