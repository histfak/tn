require_relative 'validation'

class PassengerCarriage < Carriage
  include Validation

  attr_reader :type

  def initialize(capacity)
    super(capacity)
    @type = 'Passenger'
  end

  def load
    super(1)
  end
end
