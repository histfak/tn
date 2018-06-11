require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations

  def initialize(first, terminal)
    @stations = [first, terminal]
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station) unless [@stations.first, @stations.last].include?(station)
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

  protected

  def validate!
    raise 'Wrong arguments!' if @stations.any? { |station| station.class != Station } || first_station == terminal_station
  end
end
