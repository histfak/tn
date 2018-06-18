require_relative 'brand'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Train
  include Brand
  include InstanceCounter
  include Validation
  extend Accessors
  attr_reader :number, :speed, :station, :route, :cars, :kind

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
  validate :kind, :type, String
  validate :kind, :format, /^\w+$/i

  @@trains_list = {}

  def initialize(number, kind)
    @number = number
    @cars = []
    @kind = kind
    @speed = 0
    @@trains_list[number] = self
    validate!
    register_instance
  end

  def self.find(num)
    @@trains_list[num]
  end

  def add_route(route)
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
    @cars << carriage if speed.zero? && !@cars.include?(carriage) && carriage.kind == kind
  end

  def remove_carriage(carriage)
    @cars.delete(carriage) if !cars.empty? && speed.zero?
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
    return unless next_station
    @station.train_departure(self)
    @station = route.stations[station_index.next]
    @station.train_arrival(self)
  end

  def move_backward
    return unless previous_station
    @station.train_departure(self)
    @station = route.stations[station_index.pred]
    @station.train_arrival(self)
  end

  def go_round
    @cars.each_with_index { |car, index| yield car, index }
  end

  protected

  def station_index
    route.stations.index(@station)
  end
end
