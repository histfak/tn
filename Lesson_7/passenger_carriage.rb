require_relative 'validation'

class PassengerCarriage < Carriage
  include Validation

  attr_reader :type

  def initialize(capacity)
    super(capacity)
    @type = 'Passenger'
  end

  def take_seat
    @taken += 1 if available > 0
  end
end
