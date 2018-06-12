class CargoCarriage < Carriage
  attr_reader :type, :taken, :capacity

  def initialize(capacity)
    @capacity = capacity
    @taken = 0
    @type = 'Cargo'
    validate!
  end

  def load(number)
    @taken += number if number <= @capacity
  end

  def available
    @capacity - @taken
  end

  def validate!
    raise 'Incorrect value of capacity!' if capacity.class != Integer
    raise 'Enter a positive value!' if capacity <= 0
  end
end
