class CargoTrain < Train
  def type
    'Cargo'
  end

  def add_carriage(carriage)
    if carriage.type == type
      super(carriage)
    else
      puts 'Types must be equal!'
    end
  end
end
