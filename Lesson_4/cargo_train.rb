class CargoTrain < Train
  def initialize(number)
    super(number)
    @type = 'Cargo'
  end

  def add_carriage(carriage)
    if carriage.class == CargoCarriage && speed.zero?
      @cars << carriage
    end
  end
end
