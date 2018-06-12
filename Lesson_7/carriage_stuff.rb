module CarriageStuff
  attr_reader :type, :capacity, :taken

  def available
    @capacity - @taken
  end

  protected

  def validate!
    raise 'Incorrect value of capacity!' if capacity.class != Integer
    raise 'Enter a positive value!' if capacity <= 0
  end
end
