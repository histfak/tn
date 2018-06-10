require_relative 'instance_counter'

class Route
  include InstanceCounter::InstanceMethods
  extend InstanceCounter::ClassMethods

  attr_reader :stations

  def initialize(first, terminal)
    @stations = [first, terminal]
    register_instance
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
