class CargoTrain < Train
  def add_carriage(carriage)
    if carriage.class? == CargoCarriage
      @cars << carriage
    else
      puts 'Wrong carrige type!'
    end
    super
  end
end
