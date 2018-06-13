require_relative 'validation'

class CargoCarriage < Carriage
  include Validation

  attr_reader :type

  def initialize(capacity)
    super(capacity)
    @type = 'Cargo'
  end
end
