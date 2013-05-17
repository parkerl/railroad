class Town

  attr_reader :name, :routes

  def initialize(town)
    @name = town
    @routes = Array.new
  end

  def self.find_by_name(name)
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
    r = []
    self.routes.each do |t|
      if r.empty?
        r << t
      elsif t.distance < r.first.distance
        r.clear if r.empty?
        r << t
      else
      end
      r
    end
    town = Town.find_by_name(r.first.end_point)
    [town, r.first.distance]
  end

  def connected_to?(town)
    true if ( self.routes.select { |route| route.end_point == town } != nil )
  end

  def add_route(destination, distance)
    @routes << Route.new(destination, distance)
  end

  def self.find_or_create(town)
    if find_by_name(town)
      find_by_name(town)
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