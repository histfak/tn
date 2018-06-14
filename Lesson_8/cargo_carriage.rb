require_relative 'validation'

class CargoCarriage < Carriage
  include Validation

  def initialize(capacity)
    super(capacity, 'Cargo')
  end
end
