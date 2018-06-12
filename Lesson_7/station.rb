require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  @@instances_list = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@instances_list << self
    register_instance
  end

  def self.all
    @@instances_list
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

  def go_round
    @trains.each { |train| yield train }
  end

  protected

  def validate!
    raise 'Incorrect name!' if name.empty? || name.class != String
  end
end
