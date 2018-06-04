class CargoTrain < Train
  def initialize(number)
    super(number)
    @type = 'Cargo'
  end

  def add_carriage(carriage)
    if carriage.class? == CargoCarriage
      @cars << carriage
    else
      puts 'Wrong carriage type!'
    end
    super
  end
end
