class PassengerTrain < Train
  def initialize(number)
    super(number)
    @type = 'Passenger'
  end

  def add_carriage(carriage)
    if carriage.class? == PassengerCarriage
      @cars << carriage
    else
      puts 'Wrong carriage type!'
    end
    super
  end
end
