class PassengerCarriage < Carriage
  attr_reader :type, :capacity, :taken

  def initialize(capacity)
    @capacity = capacity
    @taken = 0
    @type = 'Passenger'
    validate!
  end

  def available
    @capacity - @taken
  end

  def take_seat
    @taken += 1 if @capacity - @taken > 0
  end

  protected

  def validate!
    raise 'Incorrect value of capacity!' if capacity.class != Integer
    raise 'Enter a positive value!' if capacity <= 0
  end
end
