require_relative 'brand'
require_relative 'instance_counter'

class Train
  include Brand
  include InstanceCounter
  attr_reader :number, :speed, :station, :route, :cars

  @@trains_list = {}

  def initialize(number)
    @number = number
    validate!
    @cars = []
    @speed = 0
    @@trains_list[number] = self
    register_instance
  end

  def self.find(num)
    @@trains_list[num]
  end

  def type; end

  def set_route(route)
    @route = route
    @station = route.first_station
    route.first_station.train_arrival(self)
  end

  def increase_speed(value)
    @speed += value
  end

  def decrease_speed(value)
    @speed -= value if @speed - value >= 0
  end

  def add_carriage(carriage)
    if speed.zero?
      @cars << carriage
    else
      puts 'You can\'t add the carriage in motion!'
    end
  end

  # maybe I had to use something like @cars.pop and write this method with no argument because any train is a stack
  def remove_carriage(carriage)
    if cars.empty?
      puts 'The train has no carriages!'
    elsif speed.zero?
      @cars.delete(carriage)
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
    if next_station
      @station.train_departure(self)
      @station = route.stations[station_index.next]
      @station.train_arrival(self)
    end
  end

  def move_backward
    if previous_station
      @station.train_departure(self)
      @station = route.stations[station_index.pred]
      @station.train_arrival(self)
    end
  end

  def valid?

  end

  protected

  def validate!
    raise 'Incorrect number!' if (number =~ /^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/) != 0
  end

  def station_index
    route.stations.index(@station)
  end
end
