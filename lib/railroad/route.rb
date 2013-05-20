class Route

  attr_reader :destination, :distance

  def initialize(destination, distance)
    @destination = destination
    @distance = distance.to_i
  end
end
