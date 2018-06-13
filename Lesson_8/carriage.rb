require_relative 'validation'

class Carriage
  include Brand

  attr_reader :capacity, :taken

  def initialize(capacity)
    @capacity = capacity
    @taken = 0
    validate!
  end

  def available
    @capacity - @taken
  end

  def load(number)
    @taken += number if number <= available
  end

  protected

  def validate!
    raise 'Incorrect value of capacity!' if capacity.class != Integer
    raise 'Enter a positive value!' if capacity <= 0
  end
end
