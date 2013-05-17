class Route

  attr_reader :end_point, :distance

  def initialize(end_point, distance)
    @end_point = end_point
    @distance = distance.to_i
  end
end