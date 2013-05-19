class Town

  attr_reader :name, :routes

  def initialize(town)
    @name = town
    @routes = []
  end

  def self.find(name)
    all.find { |town| town.name == name }
  end

  def distance_to(next_town)
    route = self.routes.select { |route| route.end_point == next_town.name }
    route.first.distance
  end

  # def connected_to?(town)
  #   true if ( self.routes.select { |route| route.end_point == town } != nil )
  # end

  def add_route(destination, distance)
    @routes << Route.new(destination, distance)
  end

  def self.find_or_create(town)
    find(town) == nil ? create(town) : find(town)
  end

  def self.create(town)
    town = Town.new(town)
    all << town
    town
  end

  def self.all
    @towns ||= []
  end

  def self.clear
    @towns.clear
  end
end