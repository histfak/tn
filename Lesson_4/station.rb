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
