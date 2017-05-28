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
      puts 'Trains: '
      trains.each { |train| puts train.number }
    else
      temp = []
      trains.each { |train| temp << train.number if train.type == type }
      if temp.empty?
        puts 'Not found!'
      else
        puts "Trains(#{type}): "
        temp.each { |x| puts x }
      end
    end
  end
  
end

class Route
  
  attr_accessor :stations, :first, :terminal
  
  def initialize (first, terminal)
    @stations = [first, terminal]
  end

  def add_station(station)
    self.stations.insert(-2, station) 
  end

  def remove_station(station)
    if [stations.first, stations.last].include?(station)
      raise 'You can\'t remove the first or terminal station!'
    else 
      self.stations.delete(station)
    end
  end

  def list_stations
    puts 'The route contains the following stations: '
    stations.each{ |station| puts station.name }
  end
    
end

class Train

  attr_accessor :speed, :route, :station, :quantity
  attr_reader :number, :type

  def initialize(number, type, quantity)
    @number = number
    @type = type
    @quantity = quantity
    @speed = 0
  end
  
  def set_route(route)
    self.route = route
    self.station = route.stations.first
  end

  def stop
    self.speed = 0
  end

  def add_carriage
    if speed.zero? 
      self.quantity += 1
    else 
      raise 'You can\'t add the carriage in motion!'
    end
  end

  def remove_carriage
    raise "The train has no carriages!" if quantity.zero?
    if speed.zero? 
      self.quantity -= 1
    else 
      raise 'You can\'t remove the carriage in motion!'
    end
  end

  def list_adjacent_stations
    if route.nil?
      raise 'You have to add the route first!'
    else
      station_index = route.stations.index(station)
      puts "The current station is #{station.name}."
      puts "The previous station is #{route.stations[station_index - 1].name}." if station_index != 0
      puts "The next station is #{route.stations[station_index + 1].name}." if station_index != route.stations.size - 1
    end
  end

  def move(destination)
    if route.nil?
      raise 'You have to add the route first!'
    elsif destination == station
      raise "The train \##{@number} stands at the same station (#{self.station.name})!"
    elsif route.stations.include?(destination)
      station_index = route.stations.index(station)
      if (destination == route.stations[station_index - 1] && station_index != 0) || (destination == route.stations[station_index + 1] && station_index != route.stations.size - 1)
        station.train_departure(self) if station
        self.station = destination
        station.train_arrival(self)
      else
        raise 'You have to choose the nearest station!'
      end
    else
      raise "The route doesn\'t have the #{station.name} station"
    end
  end
  
end
