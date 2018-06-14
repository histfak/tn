class PassengerTrain < Train
  def initialize(number)
    super(number, 'Passenger')
  end

  def add_carriage(carriage)
    super(carriage) if carriage.type == type
  end
end
