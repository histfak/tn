#!/usr/bin/env ruby
class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrival(train)
    trains << train
  end

  def train_departure(train)
    trains.delete(train)
    train.station = nil
  end

  def trains_status(type = nil)
    if type.nil?
      trains
    else
      trains.select { |train| type == train.type }
    end
  end
end

class Route
  attr_reader :stations

  def initialize(first, terminal)
    @stations = [first, terminal]
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def remove_station(station)
    if [stations.first, stations.last].include?(station)
      puts 'You can\'t remove the first or terminal station!'
    else
      self.stations.delete(station)
    end
  end

  def list_stations
    puts 'The route contains the following stations: '
    stations.each { |station| puts station.name }
  end
end

class Train
  attr_accessor :speed, :route, :station, :cars
  attr_reader :number, :type

  def initialize(number, type, cars)
    @number = number
    @type = type
    @cars = cars
    @speed = 0
  end

  def set_route(route)
    self.route = route
    self.station = route.stations.first
    route.stations.first.train_arrival(self)
  end

  def set_speed(speed)
    if speed > 0
      self.speed = speed
    else
      puts 'Speed must be > 0!'
    end
  end

  def stop
    self.speed = 0
  end

  def add_carriage
    if speed.zero?
      self.cars += 1
    else
      puts 'You can\'t add the carriage in motion!'
    end
  end

  def remove_carriage
    puts "The train has no carriages!" if cars.zero?
    if speed.zero?
      self.cars -= 1
    else
      puts 'You can\'t remove the carriage in motion!'
    end
  end

  def list_current_station
    if route.nil?
      puts 'You have to add the route first!'
    else
      station.name
    end
  end

  def list_previous_station
    if route.nil?
      puts 'You have to add the route first!'
    else
      station_index = route.stations.index(station)
      route.stations[station_index - 1].name if station_index != 0
    end
  end

  def list_next_station
    if route.nil?
      puts 'You have to add the route first!'
    else
      station_index = route.stations.index(station)
      route.stations[station_index + 1].name if station_index != route.stations.size - 1
    end
  end

  def move_forward
    if route.nil?
      puts 'You have to add the route first!'
    else
      station_index = route.stations.index(station)
      station.train_departure(self)
      self.station = route.stations[station_index.next]
      station.train_arrival(self)
    end
  end

  def move_backward
    if route.nil?
      puts 'You have to add the route first!'
    else
      station_index = route.stations.index(station)
      station.train_departure(self)
      self.station = route.stations[station_index.pred]
      station.train_arrival(self)
    end
  end
end