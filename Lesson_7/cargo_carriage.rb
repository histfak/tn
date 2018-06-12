require_relative 'validation'
require_relative 'carriage_stuff'

class CargoCarriage < Carriage
  include CarriageStuff

  def initialize(capacity)
    @capacity = capacity
    @taken = 0
    @type = 'Cargo'
    validate!
  end

  def load(number)
    @taken += number if number <= @capacity
  end
end
