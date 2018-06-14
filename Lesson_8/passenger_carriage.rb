require_relative 'validation'

class PassengerCarriage < Carriage
  include Validation

  def initialize(capacity)
    super(capacity, 'Passenger')
  end

  def load
    super(1)
  end
end
