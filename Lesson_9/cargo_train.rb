require_relative 'brand'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class CargoTrain < Train
  def initialize(number)
    super(number, 'Cargo')
  end
end
