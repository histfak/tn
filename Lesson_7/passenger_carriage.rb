require_relative 'validation'
require_relative 'carriage_stuff'

class PassengerCarriage < Carriage
  include CarriageStuff

  def initialize(capacity)
    @capacity = capacity
    @taken = 0
    @type = 'Passenger'
    validate!
  end

  def take_seat
    @taken += 1 if @capacity - @taken > 0
  end
end
