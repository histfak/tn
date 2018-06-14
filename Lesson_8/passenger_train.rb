class PassengerTrain < Train
  include Validation

  def initialize(number)
    super(number, 'Passenger')
  end
end
