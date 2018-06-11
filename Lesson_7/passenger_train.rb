class PassengerTrain < Train
  def type
    'Passenger'
  end

  def add_carriage(carriage)
    super(carriage) if carriage.type == type
  end
end
