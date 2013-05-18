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
    distance = 0
    self.routes.each do |route|
      (distance += route.distance) if route.end_point == next_town.name
    end
    distance
  end

  def shortest_route
    town = nil
    shortest = 0
    self.routes.each do |t|
      if shortest == 0
        shortest = t.distance
        town = t.end_point
      else 
        if t.distance < shortest
        shortest = t.distance
        town = t.end_point
        end
      end
    end
    [Town.find(town), shortest]
  end

  def connected_to?(town)
    true if ( self.routes.select { |route| route.end_point == town } != nil )
  end

  def add_route(destination, distance)
    @routes << Route.new(destination, distance)
  end

  def self.find_or_create(town)
    if find(town)
      find(town)
    else
     create(town)
   end
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