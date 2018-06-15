class PassengerCarriage < Carriage
  def initialize(capacity)
    super(capacity, 'Passenger')
  end

  def load
    super(1)
  end
end
