class CargoTrain < Train
  def initialize(number)
    super(number, 'Cargo')
  end

  def add_carriage(carriage)
    super(carriage) if carriage.type == type
  end
end
