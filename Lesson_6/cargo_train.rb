class CargoTrain < Train
  def type
    'Cargo'
  end

  def add_carriage(carriage)
    super(carriage) if carriage.type == type
  end
end
