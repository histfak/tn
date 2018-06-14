class CargoTrain < Train
  include Validation

  def initialize(number)
    super(number, 'Cargo')
  end
end
