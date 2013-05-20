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
    #this use or route as a variable name both
    #inside and outside the block is a possible smell
    route = self.routes.select { |route| route.destination == next_town.name }
    route.first.distance
  end

  # def connected_to?(town)
  #   true if ( self.routes.select { |route| route.destination == town } != nil )
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

  #In general you want to use class methods when they are stateless. That means
  #nothing is persited between method calls. By setting @towns here you are essentially
  #setting up a global variable. This is a code smell. I think that all the class methods
  #in this class probably belong in another abstracton such as RouteMap which might logically maintain
  #a collection of towns.
  def self.all
    @towns ||= []
  end

  def self.clear
    @towns.clear
  end
end
