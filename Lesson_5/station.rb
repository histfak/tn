require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@instances_list = []

  def initialize(name)
    @name = name
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
end
