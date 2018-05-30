#!/usr/bin/env ruby
class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrival(train)
    @trains << train
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def trains_status(type = nil)
    if type.nil?
      @trains
    else
      @trains.select { |train| type == train.type }
    end
  end
end

class Route
  attr_reader :stations

  def initialize(first, terminal)
    @stations = [first, terminal]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    if [@stations.first, @stations.last].include?(station)
      puts 'You can\'t remove the first or terminal station!'
    else
      @stations.delete(station)
    end
  end

  def first_station
    @stations.first
  end

  def terminal_station
    @stations.last
  end

  def list_stations
    puts 'The route contains the following stations: '
    @stations.each { |station| puts station.name }
  end
end

class Train
  attr_reader :number, :type, :speed, :station, :route, :cars

  def initialize(number, type, cars)
    @number = number
    @type = type
    @cars = cars
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

  def add_carriage
    if speed.zero?
      @cars += 1
    else
      puts 'You can\'t add the carriage in motion!'
    end
  end

  def remove_carriage
    if cars.zero?
      puts 'The train has no carriages!'
    elsif speed.zero?
      @cars -= 1
    else
      puts 'You can\'t remove the carriage in motion!'
    end
  end

  def current_station
    @station
  end

  def station_index
    route.stations.index(@station)
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
end
