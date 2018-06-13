class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super(number)
    @type = 'Passenger'
  end

  def add_carriage(carriage)
    super(carriage) if carriage.type == type
  end
end
