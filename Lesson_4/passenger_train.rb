class PassengerTrain < Train
  def add_carriage(carriage)
    if carriage.class? == PassengerCarriage
      @cars << carriage
    else
      puts 'Wrong carrige type!'
    end
    super
  end
end
