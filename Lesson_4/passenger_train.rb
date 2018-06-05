class PassengerTrain < Train
  def initialize(number)
    super(number)
    @type = 'Passenger'
  end

  def add_carriage(carriage)
    if carriage.class == PassengerCarriage && speed.zero?
      @cars << carriage
    end
  end
end
